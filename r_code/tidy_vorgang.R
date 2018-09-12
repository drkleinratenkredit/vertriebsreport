
vorgang <- vorgaenge %>% 
  select(Frontend,VorgangsNummer,VorgangAngelegtAmDatum,EigeneVorgangsNummerDesVertriebs,
         ImportQuelle,AuswertungsEbene3Ep2PartnerId,AuswertungsEbene3Ep2PartnerName,
         AuswertungsEbene4Ep2PartnerId,AuswertungsEbene4Ep2PartnerName,
         AuswertungsEbene5Ep2PartnerId,AuswertungsEbene5Ep2PartnerName,
         KundenbetreuerName,KundenbetreuerExternePartnerId,BearbeiterPartnerName,
         Antragsteller1Vorname,Antragsteller1Nachname,Antragsteller1Geburtsdatum,
         Antragsteller2Vorname,Antragsteller2Nachname,Antragsteller2Geburtsdatum,
         Verwendungszweck,SummeFinanzierungswunschOhneZwifi,ProduktArt,TippgeberExternePartnerId)
  #filter(VorgangAngelegtAmDatum > observation_date_since, Antragsteller1Nachname != "")
  

vorgang <- vorgang %>% 
  mutate(Frontend = as.factor(Frontend),VorgangAngelegtAmDatum = dmy(VorgangAngelegtAmDatum),
         ImportQuelle = as.factor(ImportQuelle),
         Antragsteller1Geburtsdatum = dmy(Antragsteller1Geburtsdatum),
         Antragsteller2Geburtsdatum = dmy(Antragsteller2Geburtsdatum),
         Verwendungszweck = as.factor(Verwendungszweck),
         SummeFinanzierungswunschOhneZwifi = str_replace(SummeFinanzierungswunschOhneZwifi,",","."),
         SummeFinanzierungswunschOhneZwifi = as.integer(SummeFinanzierungswunschOhneZwifi),
         ProduktArt = as.factor(ProduktArt)
  )



#-------------------------------------------------------------------------
# Die ersten 5 Stellen von 'TippgeberExternePartnerId' bilden die FilHB ab
#-------------------------------------------------------------------------
vorgang <- vorgang %>% 
  mutate(FilHB = str_sub(TippgeberExternePartnerId,1,5))



#---------------------------------------------------------------------------------
# Die Bestandteile vom Datum 'VorgangAngelagtAmDatum' werden erstellt und angefügt
#---------------------------------------------------------------------------------
vorgang <- vorgang %>% 
  mutate(angelegt_Jahr = year(VorgangAngelegtAmDatum),
         angelegt_Monat = month(VorgangAngelegtAmDatum),
         angelegt_Monatname = monatsnamen[month(VorgangAngelegtAmDatum)],
         angelegt_Tag = day(VorgangAngelegtAmDatum),
         angelegt_WTag = wday(VorgangAngelegtAmDatum, label = TRUE))


#------------------------------------------------------------------------------------------------------------------
# Mehrfachkunden werden identifiziert an dem neuen Wert Vorname+Nachname+Geburtsdatum+Datum VorgangangelegtAmDatum
#------------------------------------------------------------------------------------------------------------------
vorgang <- vorgang %>% 
  mutate(mehrfach_Kunde = paste0(Antragsteller1Vorname,Antragsteller1Nachname,Antragsteller1Geburtsdatum,VorgangAngelegtAmDatum),
         ist_mehrfach_Kunde = ifelse(duplicated(mehrfach_Kunde),1,0),
         einfach_Kunde = ifelse(duplicated(mehrfach_Kunde),0,1))


#----------------------------------------------------------------------------------------------------
# Markregion, Niederlassung und Filiale aus der Coba Datei Filialen werden anhand der FilHB angefügt
#----------------------------------------------------------------------------------------------------
filialen <- filialen %>% 
  mutate(FilHB = as.character(FilHB))

vorgang <- left_join(vorgang,filialen, by = "FilHB")


         
