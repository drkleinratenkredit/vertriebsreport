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
  mutate(Statusdatum = case_when(
           !is.na(AntragWiderrufenAntragstellerAmDatum) ~AntragWiderrufenAntragstellerAmDatum,
           !is.na(AntragAbgelehntProduktanbieterAmDatum) ~AntragAbgelehntProduktanbieterAmDatum,
           !is.na(AntragUnterschriebenBeideAmDatum) ~AntragUnterschriebenBeideAmDatum,
           !is.na(AntragUnterschriebenProduktanbieterAmDatum) ~AntragUnterschriebenProduktanbieterAmDatum,
           !is.na(AntragZurueckgestelltProduktanbieterAmDatum) ~AntragZurueckgestelltProduktanbieterAmDatum,
           !is.na(AntragUnterschriebenAntragstellerAmDatum) ~AntragUnterschriebenAntragstellerAmDatum,
           !is.na(AntragNichtAngenommenAntragstellerAmDatum) ~AntragNichtAngenommenAntragstellerAmDatum,
           !is.na(AntragBeantragtAntragstellerAmDatum) ~AntragBeantragtAntragstellerAmDatum
         ))

antrag <- antrag %>%
  mutate(Status_neu = as.factor(ifelse(Status == "ABGELEHNT_PRODUKTANBIETER" & is.na(AntragAbgelehntProduktanbieterAmDatum),
                         "UEBER_SCHNITTSTELLE_ABGELEHNT",(as.character(Status)))))

#-----------------------------------------------------------------------------------------
# Zu einem Vorgang (einer Überleitung) kann es mehrere Teilanträge geben; 
# mehrere Teilanträge bedueten aber immer noch einen und nur einen gerechneten Vorgang
# Für diese Beobachtung wird die Variabe 'Anzahl_Vorgang_gerechnet' erzeugt; eine 1 an
# der letzten Stelle der Antragsnummer wird durch eine 1 in 'Anzahl_Vorgang', angezeigt,
# jeder andere Wert wird durch eine 0 dargestellt
#------------------------------------------------------------------------------------------

antrag <- antrag %>% 
  mutate(Anzahl_Vorgang_gerechnet = ifelse((str_sub(AntragsNummer,-1))=="1",1,0))

glimpse(antrag)


