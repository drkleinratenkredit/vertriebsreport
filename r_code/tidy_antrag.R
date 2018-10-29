
#-------------------------------------------------------------------------------
# Nur im Report 'bausteine' wird der tatsächliche Auszahlungsbetrag dokumentiert
#-------------------------------------------------------------------------------
t_antrag <- left_join(teilantraege, kreditbetrag_baustein, by = "AntragsNummer")

antrag <- t_antrag %>% 
  select(VorgangsNummer,AntragsNummer,TeilAntragsNummer,ExterneVorgangsNummerDesProduktAnbieters,
         Status,AntragBeantragtAntragstellerAmDatum,AntragNichtAngenommenAntragstellerAmDatum,
         AntragWiderrufenAntragstellerAmDatum,AntragUnterschriebenAntragstellerAmDatum,
         AntragUnterschriebenBeideAmDatum,AntragUnterschriebenProduktanbieterAmDatum,
         AntragAbgelehntProduktanbieterAmDatum,AntragZurueckgestelltProduktanbieterAmDatum,
         ProduktAnbieterId,AntragAutomatischAbgelehnt,AntragManuellErzeugt,StatusVonDatum,AuszahlungsBetrag
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
# Die Ablehnung in der Vorprüfung soll als neuer Status erfasst werden mit 'ANTRAG_AUTOMATISCH_ABGELEHNT'
# + Abfangen der Santander-Problematik; für die Bank gibt es den Status 'vielleicht': Antrag wird in KS
# erzeugt und eine Stunde später wieder abgesagt
#----------------------------------------------------------------------------------------------------------
antrag <- antrag %>%
  mutate(Status_neu = as.factor(ifelse(Status == "ABGELEHNT_PRODUKTANBIETER" & AntragAutomatischAbgelehnt == TRUE,
                                       "ANTRAG_AUTOMATISCH_ABGELEHNT",
                                       ifelse(ProduktAnbieterId == "SANTANDER_CONSUMER_BANK_RATENKREDIT" &
                                                Status == "ABGELEHNT_PRODUKTANBIETER" & (StatusVonDatum - AntragBeantragtAntragstellerAmDatum) == 0 &
                                                AntragAutomatischAbgelehnt == FALSE,
                                              "ANTRAG_AUTOMATISCH_ABGELEHNT", (as.character(Status))))))
          

#---------------------------------------------------------------------------------
# Die Bestandteile vom Datum 'StatusVonDatum' werden erstellt und angefügt
#---------------------------------------------------------------------------------
antrag <- antrag %>% 
  mutate(status_Jahr = year(StatusVonDatum),
         status_Monat = month(StatusVonDatum),
         status_Monatname = name_of_month[month(StatusVonDatum)],
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
         ifelse(Status_neu == "ANTRAG_AUTOMATISCH_ABGELEHNT",1,"")
         )))))))))))
    

#-------------------------------------- 
# Kennzeichnung, ob RSV eingebunden ist
#--------------------------------------
antrag <- left_join(antrag, rsv_baustein, by = "AntragsNummer")


#--------------------------------------------------------------------------------------------------------------------------
# Aufräumaktion der DSL dokumentieren:
# Von Zeit zu Zeit befreit die DSL Bank ihr System von erzeugten Angeboten, die nicht eingereicht wurden.
# Das Aufräumen erfolgt, indem der Status jeweils weiter gedreht wird, bis die DSL den Status 'Abgelehnt'
# setzen kann. Dadurch werden bei uns im System, Anträge auf 'Eingereicht' gesetzt, die tatsächlich nie eingereicht wurden.
#--------------------------------------------------------------------------------------------------------------------------
antrag <- antrag %>% 
  mutate(DSL_hat_storniert = ifelse(ProduktAnbieterId == "DSL_BANK_RATENKREDIT" & Status == "ABGELEHNT_PRODUKTANBIETER" &
                                      is.na(AntragUnterschriebenAntragstellerAmDatum) & is.na(AntragUnterschriebenBeideAmDatum) &
                                      AntragAutomatischAbgelehnt == FALSE & 
                                      (StatusVonDatum - AntragBeantragtAntragstellerAmDatum) > days_until_cancellation,1,0))




