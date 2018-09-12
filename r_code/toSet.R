#----------------------------------------
# Joinen und Kennzahlen ermitteln
#----------------------------------------

dataset <- full_join(vorgang,antrag,by = "VorgangsNummer")

# Sortierung nach Statusrang
dataset <- arrange(dataset, desc(Statusrang))

# Kennzeichnung Mehrfachvorgangsnummern
dataset <- dataset %>% 
  mutate(vorgangsnummer_mehrfach = ifelse(duplicated(VorgangsNummer),1,0))



dataset_einfach <- dataset %>% 
  filter(vorgangsnummer_mehrfach == 0 | Statusrang == 8)

dataset_untermTisch <- dataset %>% 
  filter(vorgangsnummer_mehrfach == 1)

ds9 <- dataset_untermTisch




ds <- dataset2 %>% 
  mutate(ist_uebergeleitet = 1,
         ohne_doppelte = ifelse(einfach_Kunde == 1,1,0),
         ist_drk_bearbeitet = ifelse((!is.na(AntragsNummer) | KundenbetreuerName == "in the Field, Martin"),1,0),
         ist_angebot_erstellt = ifelse(Statusrang > 1,1,0),
         ist_angebot_eingereicht = ifelse(Statusrang > 4,1,0),
         ist_sale = ifelse(Statusrang == 6 | Statusrang == 7,1,0),
         salevolumen = ifelse(Statusrang == 6 | Statusrang == 7,SummeFinanzierungswunschOhneZwifi,0)
  )

ds2 <- arrange(ds, desc(Statusrang))

ds2 <- ds2 %>% 
  mutate(mehrfach = ifelse(duplicated(VorgangsNummer),1,0))

ds <- ds %>% 
  filter(mehrfach == 0)

antrag_group <- antrag %>% 
  group_by(VorgangsNummer) %>% 
  summarize(Statusrang == 7)



