#--------------------------------------------
# Joinen, Kennzahlen ermitteln und ausliefern
#--------------------------------------------

ds <- left_join(vorgang,antrag,by = "VorgangsNummer")

# Sortierung nach Statusrang
ds <- arrange(ds, desc(Statusrang))

# Kennzeichnung Mehrfachvorgangsnummern
ds <- ds %>% 
  mutate(vorgangsnummer_mehrfach = ifelse(duplicated(VorgangsNummer),1,0)) %>% 
  filter(vorgangsnummer_mehrfach == 0 | Statusrang == 8 | Statusrang == 7)

# Kennzahlen erzeugen
dataset <- ds %>% 
  mutate(coba_hat_abgelehnt = 1,
         ablehnungen_ohne_doppelte = ifelse(einfach_Kunde == 1,1,0),
         ist_drk_bearbeitet = ifelse((!is.na(AntragsNummer) | KundenbetreuerName == "in the Field, Martin"),1,0),
         ist_angebot_erstellt = ifelse(Statusrang == 2,1,0),
         ist_angebot_eingereicht = ifelse(Statusrang > 3,1,0),
         ist_sale = ifelse(Statusrang == 7 | Statusrang == 8,1,0),
         salevolumen = ifelse(Statusrang == 7 | Statusrang == 8,SummeFinanzierungswunschOhneZwifi,0),
         ist_manuell_angelegt = ifelse(EigeneVorgangsNummerDesVertriebs == "",1,0)
  )


write.table(dataset,paste0(getwd(),"/output/dataset_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

print("Fertig")

