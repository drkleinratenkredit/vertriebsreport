
provision <- provisionen %>% 
  select(VorgangsNummer,AntragsNummer,TeilAntragsNummer,ProduktKategorie,ProvisionBetrag,
         ForderungBeglichenAmDatum,ProduktanbieterID) %>% 
  mutate(ProduktKategorie = as.factor(ProduktKategorie),
         ProvisionBetrag = str_replace(ProvisionBetrag,",","."), ProvisionBetrag = as.numeric(ProvisionBetrag),
         ForderungBeglichenAmDatum = as_date(ForderungBeglichenAmDatum),
         ProduktanbieterID = as.factor(ProduktanbieterID))
