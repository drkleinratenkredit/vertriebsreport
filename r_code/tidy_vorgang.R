
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


#------------------------------------------------------------------------------------------------------------
# Mehrfachkunden werden identifiziert an dem neuen Wert Vorname+Nachname+Geburtsdatum+Datum Vorgang angelegt
#------------------------------------------------------------------------------------------------------------

vorgang <- vorgang %>% 
  mutate(mehrfach_Kunde = paste0(Antragsteller1Vorname,Antragsteller1Nachname,Antragsteller1Geburtsdatum,VorgangAngelegtAmDatum),
         ist_mehrfach_Kunde = ifelse(duplicated(mehrfach_Kunde),1,0))


         
