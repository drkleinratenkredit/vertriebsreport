#----------------------------------------
# Joinen und Kennzahlen ermitteln
#----------------------------------------

# Hinzufügen der Coba Filialstruktur

filialen <- filialen %>% 
  mutate(FilHB = as.character(FilHB))

vorgang <- right_join(vorgang,filialen, by = "FilHB")

antrag_einfach <- left_join(antrag_einfach, rsv_baustein, by = "AntragsNummer")

dataset <- left_join(vorgang, antrag_einfach, by = "VorgangsNummer")


