#-----------------------------------------------------------------------------
# Aus der Datei 'teilantraege.csv' werden Felder selektiert und die erforderlichen
# Datentypen entsprechend angepasst
#-----------------------------------------------------------------------------

antrag <- teilantraege %>% 
  select(VorgangsNummer,AntragsNummer,TeilAntragsNummer,ExterneVorgangsNummerDesProduktAnbieters,
         Status,AntragBeantragtAntragstellerAmDatum,AntragNichtAngenommenAntragstellerAmDatum,
         AntragWiderrufenAntragstellerAmDatum,AntragUnterschriebenAntragstellerAmDatum,
         AntragUnterschriebenBeideAmDatum,AntragUnterschriebenProduktanbieterAmDatum,
         AntragAbgelehntProduktanbieterAmDatum,AntragZurueckgestelltProduktanbieterAmDatum,
         ProduktAnbieterId,AntragAutomatischAbgelehnt,AntragManuellErzeugt
  )

antrag <- antrag %>% 
  mutate(Status = as.factor(Status),
         AntragBeantragtAntragstellerAmDatum = as_date(AntragBeantragtAntragstellerAmDatum),
         AntragNichtAngenommenAntragstellerAmDatum = as_date(AntragNichtAngenommenAntragstellerAmDatum),
         AntragWiderrufenAntragstellerAmDatum = as_date(AntragWiderrufenAntragstellerAmDatum),
         AntragUnterschriebenAntragstellerAmDatum = as_date(AntragUnterschriebenAntragstellerAmDatum),
         AntragUnterschriebenBeideAmDatum = as_date(AntragUnterschriebenBeideAmDatum),
         AntragUnterschriebenProduktanbieterAmDatum = as_date(AntragUnterschriebenProduktanbieterAmDatum),
         AntragAbgelehntProduktanbieterAmDatum = as_date(AntragAbgelehntProduktanbieterAmDatum),
         AntragZurueckgestelltProduktanbieterAmDatum = as_date(AntragZurueckgestelltProduktanbieterAmDatum),
         ProduktAnbieterId = as.factor(ProduktAnbieterId)
  )

#----------------------------------------------------------------
# Ermittlung des Status und des Datums des letzten Statuseintrags
#----------------------------------------------------------------

# Wenn der 'Status' 'ABGELEHNT_PRODUKTANBIETER' ist und im Feld 'AntragAbgelehntProduktanbieterAmDatum'
# kein Datum vorhanden ist, dann wurde die Anfrage in der Vorprüfung abgelehnt und zwar am Datum, das
# im Feld 'AntragBeantragtAntragstellerAmDatum' eingetragen ist

# Die Ablehnung in der Vorprüfung soll als neuer Status erfasst werden mit 'UEBER_SCHNITTSTELLE_ABGELEHNT'
# Es gibt ein weiteres Feld 'Statusdatum' , das das Datum des höchsten Status aufnimmt

antrag <- antrag %>% 
  mutate(Status = ifelse((Status == "ABGELEHNT_PRODUKTANBIETER" & is.na(AntragAbgelehntProduktanbieterAmDatum)),
                         "UEBER_SCHNITTSTELLE_ABGELEHNT","ABGELEHNT_PRODUKTANBIETER"),
         Statusdatum = case_when(
           !is.na(AntragWiderrufenAntragstellerAmDatum) ~AntragWiderrufenAntragstellerAmDatum,
           !is.na(AntragAbgelehntProduktanbieterAmDatum) ~AntragAbgelehntProduktanbieterAmDatum,
           !is.na(AntragUnterschriebenBeideAmDatum) ~AntragUnterschriebenBeideAmDatum,
           !is.na(AntragUnterschriebenProduktanbieterAmDatum) ~AntragUnterschriebenProduktanbieterAmDatum,
           !is.na(AntragZurueckgestelltProduktanbieterAmDatum) ~AntragZurueckgestelltProduktanbieterAmDatum,
           !is.na(AntragUnterschriebenAntragstellerAmDatum) ~AntragUnterschriebenAntragstellerAmDatum,
           !is.na(AntragNichtAngenommenAntragstellerAmDatum) ~AntragNichtAngenommenAntragstellerAmDatum,
           !is.na(AntragBeantragtAntragstellerAmDatum) ~AntragBeantragtAntragstellerAmDatum
         ))


glimpse(antrag)
