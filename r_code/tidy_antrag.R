
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


#----------------------------------------------------------------------------------------------------------------------
# Wenn ein gerechnetes Angebot nicht zum Tragen kommt, es also gar nicht erst bei der Bank eingereicht wird oder
# der Antrag wird eingereicht, aber der Nachforderung von Unterlagen wird nicht nach gekommen, 'räumen' einige
# Banken wie z.B. die DSL Bank ihre 'Bestände' auf und stornieren die Anträge / Angebote. Zur Abbildung des Geschehens
# soll es deswegen auch einen Status 'Storniert' geben. Die hier verwendete Logik:
# Ist nach 6 Monaten (180 Tagen) nichts passiert, wird der Status 'Storniert' gesetzt.
#----------------------------------------------------------------------------------------------------------------------

antrag <- antrag %>% 
  mutate(Status_neu = (ifelse(is.na(AntragNichtAngenommenAntragstellerAmDatum) &
    is.na(AntragWiderrufenAntragstellerAmDatum) &
    is.na(AntragUnterschriebenAntragstellerAmDatum) &
    is.na(AntragUnterschriebenBeideAmDatum) &
    is.na(AntragUnterschriebenProduktanbieterAmDatum)&
    is.na(AntragAbgelehntProduktanbieterAmDatum) &
    is.na(AntragZurueckgestelltProduktanbieterAmDatum) & (today()-AntragBeantragtAntragstellerAmDatum)
    >= time_until_cancellation, "PRODUKTANBIETER_HAT_STORNIERT", as.character(Status_neu))))
  
# Statusrang erzeugen

antrag <- antrag %>% 
  mutate(Statusrang = as.numeric(ifelse(Status_neu == "PRODUKTANBIETER_HAT_STORNIERT",10,
         ifelse(Status_neu == "WIDERRUFEN_ANTRAGSTELLER",9,
         ifelse(Status_neu == "ABGELEHNT_PRODUKTANBIETER",8,
         ifelse(Status_neu == "UNTERSCHRIEBEN_BEIDE",7,
         ifelse(Status_neu == "UNTERSCHRIEBEN_PRODUKTANBIETER",6,
         ifelse(Status_neu == "ZURUECKGESTELLT_PRODUKTANBIETER",5,
         ifelse(Status_neu == "UNTERSCHRIEBEN_ANTRAGSTELLER",4,
         ifelse(Status_neu == "NICHT_ANGENOMMEN_ANTRAGSTELLER",3,
         ifelse(Status_neu == "BEANTRAGT_ANTRAGSTELLER",2,
         ifelse(Status_neu == "UEBER_SCHNITTSTELLE_ABGELEHNT",1,"")
         )))))))))))
                      



