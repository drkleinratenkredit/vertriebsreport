
antrag <- teilantraege %>% 
  select(VorgangsNummer,AntragsNummer,TeilAntragsNummer,ExterneVorgangsNummerDesProduktAnbieters,
         Status,AntragBeantragtAntragstellerAmDatum,AntragNichtAngenommenAntragstellerAmDatum,
         AntragWiderrufenAntragstellerAmDatum,AntragUnterschriebenAntragstellerAmDatum,
         AntragUnterschriebenBeideAmDatum,AntragUnterschriebenProduktanbieterAmDatum,
         AntragAbgelehntProduktanbieterAmDatum,AntragZurueckgestelltProduktanbieterAmDatum,
         ProduktAnbieterId)

# Es existieren mehr Status mit Datum als an Kategorien unter der Variablen Status vorhanden sind
# Es ist sinnvoll, den jeweils höchsten Status mit dem jeweiligen Datum konsistent darzustellen

antrag <- antrag %>% 
  mutate(status_datum = case_when(
    AntragWiderrufenAntragstellerAmDatum != "" ~AntragWiderrufenAntragstellerAmDatum,
    AntragAbgelehntProduktanbieterAmDatum != "" ~ AntragAbgelehntProduktanbieterAmDatum,
    AntragUnterschriebenBeideAmDatum != "" ~AntragUnterschriebenBeideAmDatum,
    AntragUnterschriebenProduktanbieterAmDatum != "" ~AntragUnterschriebenProduktanbieterAmDatum,
    AntragZurueckgestelltProduktanbieterAmDatum != "" ~AntragZurueckgestelltProduktanbieterAmDatum,
    AntragUnterschriebenAntragstellerAmDatum != "" ~AntragUnterschriebenAntragstellerAmDatum,
    AntragNichtAngenommenAntragstellerAmDatum != "" ~AntragNichtAngenommenAntragstellerAmDatum,
    AntragBeantragtAntragstellerAmDatum != "" ~AntragBeantragtAntragstellerAmDatum),
    
    status_erweitert = case_when(
      AntragWiderrufenAntragstellerAmDatum != "" ~"WiderrufenAntragsteller",
      AntragAbgelehntProduktanbieterAmDatum != "" ~ "AbgelehntProduktanbieter",
      AntragUnterschriebenBeideAmDatum != "" ~"UnterschriebenBeideAmDatum",
      AntragUnterschriebenProduktanbieterAmDatum != "" ~"UnterschriebenProduktanbieter",
      AntragZurueckgestelltProduktanbieterAmDatum != "" ~"ZurueckgestelltProduktanbieter",
      AntragUnterschriebenAntragstellerAmDatum != "" ~"UnterschriebenAntragsteller",
      AntragNichtAngenommenAntragstellerAmDatum != "" ~"AngenommenAntragsteller",
      AntragBeantragtAntragstellerAmDatum != "" ~"BeantragtAntragsteller"),
    
    Status = as.factor(Status),
    status_erweitert = as.factor(status_erweitert),
    AntragBeantragtAntragstellerAmDatum = as_date(AntragBeantragtAntragstellerAmDatum,format = "%d.%m.%Y", tz = "UTC"),
    AntragNichtAngenommenAntragstellerAmDatum = as_date(AntragNichtAngenommenAntragstellerAmDatum,format = "%d.%m.%Y", tz = "UTC"),
    AntragWiderrufenAntragstellerAmDatum = as_date(AntragWiderrufenAntragstellerAmDatum,format = "%d.%m.%Y", tz = "UTC"),
    AntragUnterschriebenAntragstellerAmDatum = as_date(AntragUnterschriebenAntragstellerAmDatum,format = "%d.%m.%Y", tz = "UTC"),
    AntragUnterschriebenBeideAmDatum = as_date(AntragUnterschriebenBeideAmDatum,format = "%d.%m.%Y", tz = "UTC"),
    AntragUnterschriebenProduktanbieterAmDatum = as_date(AntragUnterschriebenProduktanbieterAmDatum,format = "%d.%m.%Y", tz = "UTC"),
    AntragAbgelehntProduktanbieterAmDatum = as_date(AntragAbgelehntProduktanbieterAmDatum,format = "%d.%m.%Y", tz = "UTC"),
    AntragZurueckgestelltProduktanbieterAmDatum = as_date(AntragZurueckgestelltProduktanbieterAmDatum,format = "%d.%m.%Y", tz = "UTC"),
    status_datum = as_date(status_datum, format = "%d.%m.%Y", tz = "UTC"))
    
      
  
    
    
    


glimpse(antrag)


