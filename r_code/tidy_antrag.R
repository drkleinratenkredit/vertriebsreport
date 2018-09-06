
antrag <- teilantraege %>% 
  select(VorgangsNummer,AntragsNummer,TeilAntragsNummer,ExterneVorgangsNummerDesProduktAnbieters,
         Status,AntragBeantragtAntragstellerAmDatum,AntragNichtAngenommenAntragstellerAmDatum,
         AntragWiderrufenAntragstellerAmDatum,AntragUnterschriebenAntragstellerAmDatum,
         AntragUnterschriebenBeideAmDatum,AntragUnterschriebenProduktanbieterAmDatum,
         AntragAbgelehntProduktanbieterAmDatum,AntragZurueckgestelltProduktanbieterAmDatum,
         ProduktAnbieterId,AntragAutomatischAbgelehnt,AntragManuellErzeugt,StatusVonDatum
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
         ProduktAnbieterId = as.factor(ProduktAnbieterId),
         StatusVonDatum = as_date(StatusVonDatum)
  )

#----------------------------------------------------------------------------------------------------------
# Die Ablehnung in der Vorprüfung soll als neuer Status erfasst werden mit 'UEBER_SCHNITTSTELLE_ABGELEHNT'
# Es gibt ein weiteres Feld 'Statusdatum' , das das Datum des höchsten Status aufnimmt
#----------------------------------------------------------------------------------------------------------

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

# antrag <- antrag %>% 
#   mutate(Status_neu = (ifelse(is.na(AntragNichtAngenommenAntragstellerAmDatum) &
#     is.na(AntragWiderrufenAntragstellerAmDatum) &
#     is.na(AntragUnterschriebenAntragstellerAmDatum) &
#     is.na(AntragUnterschriebenBeideAmDatum) &
#     is.na(AntragUnterschriebenProduktanbieterAmDatum)&
#     is.na(AntragAbgelehntProduktanbieterAmDatum) &
#     is.na(AntragZurueckgestelltProduktanbieterAmDatum))))
  

#---------------------------------------------------------------------------------
# Die Bestandteile vom Datum 'StatusVonDatum' werden erstellt und angefügt
#---------------------------------------------------------------------------------

antrag <- antrag %>% 
  mutate(status_Jahr = year(StatusVonDatum),
         status_Monat = month(StatusVonDatum),
         status_Monatname = monatsnamen[month(StatusVonDatum)],
         status_Tag = day(StatusVonDatum),
         status_WTag = wday(StatusVonDatum, label = TRUE))


#-------------------------------------------------------------------------------
# Statusrang erzeugen und die Tabelle nach Status sortieren (der höchste zuerst)
#-------------------------------------------------------------------------------

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
                      
#--------------------------------------------------------------------------------------------------
# Die Datensätze werden nach dem Statusrang sortiert und es verbleibt nur noch der (ein) Teilantrag
# mit dem höchsten Status
#--------------------------------------------------------------------------------------------------

antrag <- arrange(antrag, desc(Statusrang))

antrag <- antrag %>% 
  mutate(mehrfach_vorgang = ifelse(duplicated(VorgangsNummer),1,0))

antrag_einfach <- antrag %>% 
  filter(mehrfach_vorgang != 1)



