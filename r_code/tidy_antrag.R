
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
         AntragBeantragtAntragstellerAmDatum = dmy(AntragBeantragtAntragstellerAmDatum),
         AntragNichtAngenommenAntragstellerAmDatum = dmy(AntragNichtAngenommenAntragstellerAmDatum),
         AntragWiderrufenAntragstellerAmDatum = dmy(AntragWiderrufenAntragstellerAmDatum),
         AntragUnterschriebenAntragstellerAmDatum = dmy(AntragUnterschriebenAntragstellerAmDatum),
         AntragUnterschriebenBeideAmDatum = dmy(AntragUnterschriebenBeideAmDatum),
         AntragUnterschriebenProduktanbieterAmDatum = dmy(AntragUnterschriebenProduktanbieterAmDatum),
         AntragAbgelehntProduktanbieterAmDatum = dmy(AntragAbgelehntProduktanbieterAmDatum),
         AntragZurueckgestelltProduktanbieterAmDatum = dmy(AntragZurueckgestelltProduktanbieterAmDatum),
         ProduktAnbieterId = as.factor(ProduktAnbieterId),
         StatusVonDatum = dmy(StatusVonDatum)
  )


#----------------------------------------------------------------------------------------------------------
# Die Ablehnung in der Vorprüfung soll als neuer Status erfasst werden mit 'UEBER_SCHNITTSTELLE_ABGELEHNT'
# Es gibt ein weiteres Feld 'Statusdatum' , das das Datum des höchsten Status aufnimmt
#----------------------------------------------------------------------------------------------------------
antrag <- antrag %>%
  mutate(Status_neu = as.factor(ifelse(Status == "ABGELEHNT_PRODUKTANBIETER" & is.na(AntragAbgelehntProduktanbieterAmDatum),
                         "UEBER_SCHNITTSTELLE_ABGELEHNT",(as.character(Status)))))


#---------------------------------------------------------------------------------
# Die Bestandteile vom Datum 'StatusVonDatum' werden erstellt und angefügt
#---------------------------------------------------------------------------------
antrag <- antrag %>% 
  mutate(status_Jahr = year(StatusVonDatum),
         status_Monat = month(StatusVonDatum),
         status_Monatname = monatsnamen[month(StatusVonDatum)],
         status_Tag = day(StatusVonDatum),
         status_WTag = wday(StatusVonDatum, label = TRUE))


#--------------------
# Statusrang erzeugen 
#--------------------
antrag <- antrag %>% 
  mutate(Statusrang = as.numeric(ifelse(Status_neu == "PRODUKTANBIETER_HAT_STORNIERT",10,
         ifelse(Status_neu == "WIDERRUFEN_ANTRAGSTELLER",9,
         ifelse(Status_neu == "UNTERSCHRIEBEN_BEIDE",8,  
         ifelse(Status_neu == "UNTERSCHRIEBEN_PRODUKTANBIETER",7,     
         ifelse(Status_neu == "ABGELEHNT_PRODUKTANBIETER",6,
         ifelse(Status_neu == "ZURUECKGESTELLT_PRODUKTANBIETER",5,
         ifelse(Status_neu == "UNTERSCHRIEBEN_ANTRAGSTELLER",4,
         ifelse(Status_neu == "NICHT_ANGENOMMEN_ANTRAGSTELLER",3,
         ifelse(Status_neu == "BEANTRAGT_ANTRAGSTELLER",2,
         ifelse(Status_neu == "UEBER_SCHNITTSTELLE_ABGELEHNT",1,"")
         )))))))))))
    
 
# Kennzeichnung, ob RSV eingebunden ist

antrag <- left_join(antrag, rsv_baustein, by = "AntragsNummer")

