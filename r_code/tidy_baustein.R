
baustein <- bausteine %>% 
  select(VorgangsNummer,AntragsNummer,TeilAntragsNummer,BausteinArt,BausteinBetrag,Sollzins,Effektivzins,
         LaufzeitJahre,AuszahlungsBetrag,BausteinProduktanbieterId,Produktkategorie) %>% 
  mutate(BausteinArt = as.factor(BausteinArt),
         BausteinBetrag = str_replace(BausteinBetrag,",","."),BausteinBetrag = as.numeric(BausteinBetrag),
         Sollzins = str_replace(Sollzins,",","."),Sollzins = as.numeric(Sollzins),
         Effektivzins = str_replace(Effektivzins,",","."),Effektivzins = as.numeric(Effektivzins),
         LaufzeitJahre = str_replace(LaufzeitJahre,",","."),LaufzeitJahre = as.numeric(LaufzeitJahre),
         AuszahlungsBetrag = str_replace(AuszahlungsBetrag,",","."),AuszahlungsBetrag = as.numeric(AuszahlungsBetrag),
         BausteinProduktanbieterId = as.factor(BausteinProduktanbieterId),
         Produktkategorie = as.factor(Produktkategorie),
         LaufzeitJahre = LaufzeitJahre * 12)
names(baustein)[8] <- "LaufzeitMonate"

# Zur Zeit werden aus dem Report 'bausteine' Informationen zu Ratenschutz und Auszahlungsbetrag benötigt
rsv_baustein <- baustein %>% 
  select(AntragsNummer, BausteinArt) %>% 
  filter(BausteinArt == "Restschuldversicherung")

kreditbetrag_baustein <- baustein %>% 
  select(AntragsNummer, AuszahlungsBetrag) %>% 
  filter(!is.na(AuszahlungsBetrag))
