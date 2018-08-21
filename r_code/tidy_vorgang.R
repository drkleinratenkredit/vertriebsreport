
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
         SummeFinanzierungswunschOhneZwifi = as.numeric(SummeFinanzierungswunschOhneZwifi),
         ProduktArt = as.factor(ProduktArt)
  )

#--------------------------------------------------------------------------------------------
# Das neue Objekt 'vorgang' wird mit einem Feld ergänzt, aus dem sich Mehrfach-Datensaetze
# bestimmen lassen. Dieses Feld ist eine Zusammensetzung von Vorname, Name und
# Geburtsdatum des Antragsteller1; die Variable 'mehrfach_vorgang' nimmt TRUE oder FALSE auf
#--------------------------------------------------------------------------------------------

vorgang <- vorgang %>% 
  mutate(mehrfachID = paste0(Antragsteller1Vorname,Antragsteller1Nachname,Antragsteller1Geburtsdatum),
         mehrfach_vorgang = duplicated(mehrfachID)
  )

