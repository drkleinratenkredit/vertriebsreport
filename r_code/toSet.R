#----------------------------------------
# Joinen und Kennzahlen ermitteln
#----------------------------------------

# Hinzufügen der Coba Filialstruktur

filialen <- filialen %>% 
  mutate(FilHB = as.character(FilHB))

vorgang <- right_join(vorgang,filialen, by = "FilHB")

dataset <- left_join(vorgang, antrag_einfach, by = "VorgangsNummer")


