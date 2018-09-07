
dataset_rk_vertrieb <- dataset %>% 
  mutate(ist_martin_in_the_field = ifelse(KundenbetreuerName == "in the Field, Martin",1,0),
         name_mitarbeiter =  ifelse(KundenbetreuerName == "in the Field, Martin",BearbeiterPartnerName,KundenbetreuerName),
         name_mitarbeiter = str_replace(name_mitarbeiter," DK",""),
         ist_uebergeleitet = ifelse(KundenbetreuerExternePartnerId == "",1,0),
         ist_nicht_uebergeleitet = ifelse(KundenbetreuerExternePartnerId != "",1,0),
         gerechnet = ifelse(Statusrang >=1 & Statusrang <= 9,1,0),
         angebot_erstellt = ifelse(Statusrang >= 2 & Statusrang <= 9,1,0),
         eingereicht = ifelse(Statusrang >= 4 & Statusrang <= 9,1,0),
         genehmigt = ifelse(Statusrang == 6 | Statusrang == 7,1,0),
         abgelehnt = ifelse(Statusrang == 8,1,0))

dataset_rk_vertrieb <- dataset_rk_vertrieb %>% 
  mutate(gerechnet = ifelse(is.na(gerechnet),0,as.integer(gerechnet)),
         angebot_erstellt = ifelse(is.na(angebot_erstellt),0,as.integer(angebot_erstellt)),
         eingereicht = ifelse(is.na(eingereicht),0,as.integer(eingereicht)),
         genehmigt = ifelse(is.na(genehmigt),0,as.integer(genehmigt)),
         abgelehnt = ifelse(is.na(abgelehnt),0,as.integer(abgelehnt)))

dataset_rk_vertrieb <- dataset_rk_vertrieb %>% 
  mutate(sale_volumen = ifelse(genehmigt == 1,SummeFinanzierungswunschOhneZwifi,0))
        