
#-----------------------------------------------------------------------------
# Aus der Datei 'vorgaenge.csv' werden Felder selektiert und die erforderlichen
# Datentypen entsprechend angepasst
#-----------------------------------------------------------------------------

vorgang <- vorgaenge %>% 
  select(Frontend,VorgangsNummer,VorgangAngelegtAmDatum,EigeneVorgangsNummerDesVertriebs,
         ImportQuelle,AuswertungsEbene3Ep2PartnerId,AuswertungsEbene3Ep2PartnerName,
         AuswertungsEbene4Ep2PartnerId,AuswertungsEbene4Ep2PartnerName,
         AuswertungsEbene5Ep2PartnerId,AuswertungsEbene5Ep2PartnerName,
         KundenbetreuerName,KundenbetreuerExternePartnerId,BearbeiterPartnerName,
         Antragsteller1Vorname,Antragsteller1Nachname,Antragsteller1Geburtsdatum,
         Antragsteller2Vorname,Antragsteller2Nachname,Antragsteller2Geburtsdatum,
         Verwendungszweck,SummeFinanzierungswunschOhneZwifi,ProduktArt,TippgeberExternePartnerId) %>% 
  filter(VorgangAngelegtAmDatum > observation_date_since, Antragsteller1Nachname != "")
  

vorgang <- vorgang %>% 
  mutate(Frontend = as.factor(Frontend),VorgangAngelegtAmDatum = as_date(VorgangAngelegtAmDatum),
         ImportQuelle = as.factor(ImportQuelle),
         Antragsteller1Geburtsdatum = as_date(Antragsteller1Geburtsdatum),
         Antragsteller2Geburtsdatum = as_date(Antragsteller2Geburtsdatum),
         Verwendungszweck = as.factor(Verwendungszweck),
         SummeFinanzierungswunschOhneZwifi = str_replace(SummeFinanzierungswunschOhneZwifi,",","."),
         SummeFinanzierungswunschOhneZwifi = as.numeric(SummeFinanzierungswunschOhneZwifi),
         ProduktArt = as.factor(ProduktArt)
  )


#--------------------------------------------------------------------------------------------
# Erzeugung der Variablen mehrfachID und ist_mehrfach_uebergeleitet
#--------------------------------------------------------------------------------------------

# Zu hinterfragen: Wann zählt eine Überleitung als Doppelt und soll herausgerechnet werden?
# Beispiel: Vorgangsnummer RG2475 am 19.06.2018 angelegt und A88341 am 28.02.2018 angelegt 
# beides Rocco Silipo

vorgang <- arrange(vorgang, desc(VorgangAngelegtAmDatum))

vorgang <- vorgang %>% 
  mutate(mehrfachID = paste0(Antragsteller1Vorname,Antragsteller1Nachname,Antragsteller1Geburtsdatum,VorgangAngelegtAmDatum),
         brutto_Lead = 1,
         ist_mehrfach_uebergeleitet = ifelse(duplicated(mehrfachID),1,0),
         ist_Einfach = ifelse(ist_mehrfach_uebergeleitet == FALSE,1,0),
         an_DrKlein_uebergeleitet = ifelse(KundenbetreuerExternePartnerId == "" & 
                                             ist_mehrfach_uebergeleitet != 1,1,0))

#---------------------------------------------------------------
# Extrahierung der FilHB aus dem Feld TippgeberExternePartnerId
#---------------------------------------------------------------
vorgang <- vorgang %>% 
  mutate(FilHB = str_sub(TippgeberExternePartnerId,1,5))

#---------------------------------------------------------------------------------
# Die Bestandteile vom Datum 'VorgangAngelagtAmDatum' werden erstellt und angefügt
#---------------------------------------------------------------------------------
monate = c("Januar","Februar","März","April","Mai","Jumi","Juli","August","September","Oktober","November","Dezember")
tvor <- vorgang %>% 
  mutate(angelegt_Jahr = year(VorgangAngelegtAmDatum),
         angelegt_Monat = month(VorgangAngelegtAmDatum),
         angelegt_Monatname = monate[month(VorgangAngelegtAmDatum)],
         angelegt_Tag = day(VorgangAngelegtAmDatum),
         angelegt_WTag = wday(VorgangAngelegtAmDatum, label = TRUE))



#-----------------------------------
# Hinzufügen der Coba Filialstruktur
#-----------------------------------
filialen <- filialen %>% 
  mutate(FilHB = as.character(FilHB))



         


