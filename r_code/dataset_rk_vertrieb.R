
dataset_rk_vertrieb <- dataset %>% 
  mutate(ist_martin_in_the_field = ifelse(KundenbetreuerName == "in the Field, Martin",1,0),
         name_mitarbeiter =  ifelse(KundenbetreuerName == "in the Field, Martin",BearbeiterPartnerName,KundenbetreuerName),
         name_mitarbeiter = str_replace(name_mitarbeiter," DK",""),
         ist_uebergeleitet = ifelse(KundenbetreuerExternePartnerId == "",1,0),
         ist_nicht_uebergeleitet = ifelse(KundenbetreuerExternePartnerId != "",1,0),
         gerechnet = ifelse((Status_neu == "UEBER_SCHNITTSTELLE_ABGELEHNT" | !is.na(AntragBeantragtAntragstellerAmDatum) |
                               !is.na(AntragNichtAngenommenAntragstellerAmDatum) | !is.na(AntragUnterschriebenAntragstellerAmDatum) |
                               !is.na(AntragUnterschriebenBeideAmDatum) | !is.na(AntragUnterschriebenProduktanbieterAmDatum) |
                               !is.na(AntragAbgelehntProduktanbieterAmDatum) | !is.na(AntragZurueckgestelltProduktanbieterAmDatum) |
                               !is.na(AntragWiderrufenAntragstellerAmDatum)),1,0),
         angebot_erstellt = ifelse((!is.na(AntragBeantragtAntragstellerAmDatum) |
                               !is.na(AntragNichtAngenommenAntragstellerAmDatum) | !is.na(AntragUnterschriebenAntragstellerAmDatum) |
                               !is.na(AntragUnterschriebenBeideAmDatum) | !is.na(AntragUnterschriebenProduktanbieterAmDatum) |
                               !is.na(AntragAbgelehntProduktanbieterAmDatum) | !is.na(AntragZurueckgestelltProduktanbieterAmDatum) |
                               !is.na(AntragWiderrufenAntragstellerAmDatum)),1,0),
         eingereicht = ifelse((!is.na(AntragUnterschriebenAntragstellerAmDatum) | !is.na(AntragUnterschriebenBeideAmDatum) |
                               !is.na(AntragUnterschriebenProduktanbieterAmDatum) | !is.na(AntragAbgelehntProduktanbieterAmDatum) |
                               !is.na(AntragZurueckgestelltProduktanbieterAmDatum) |is.na(AntragWiderrufenAntragstellerAmDatum)),1,0),
         genehmigt = ifelse((!is.na(AntragBeantragtAntragstellerAmDatum) | !is.na(AntragUnterschriebenAntragstellerAmDatum) |
                             !is.na(AntragUnterschriebenBeideAmDatum) | !is.na(AntragUnterschriebenProduktanbieterAmDatum)),1,0),
         abgelehnt = ifelse((!is.na(AntragBeantragtAntragstellerAmDatum) | !is.na(AntragUnterschriebenAntragstellerAmDatum) |
                             !is.na(AntragAbgelehntProduktanbieterAmDatum)),1,0))
         
    


