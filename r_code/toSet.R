#----------------------------------------
# Joinen und Kennzahlen ermitteln
#----------------------------------------

# Hinzufügen der Coba Filialstruktur

filialen <- filialen %>% 
  mutate(FilHB = as.character(FilHB))

vorgang <- right_join(vorgang,filialen, by = "FilHB")

vorgang_antrag <- left_join(vorgang,antrag, by = "VorgangsNummer")

vorgang_antrag <- vorgang_antrag %>% 
  mutate(Statusrang = as.integer((ifelse(is.na(Statusrang),0,Statusrang))))

dataset <- vorgang_antrag %>% 
  mutate(bruttolead = ifelse(duplicated(VorgangsNummer),0,1),
         nettolead = !(!bruttolead & ist_mehrfach_Kunde))


