#--------------------------------
# Joinen und Kennzahlen ermitteln
#--------------------------------

# Zusammenfassung der Vorgänge und (Teil)Anträge zu einem Dataset
vor_an <- full_join(vorgang, antrag, by = "VorgangsNummer")

vor_an_l <- left_join(vorgang, antrag, by = "VorgangsNummer")

# An Dr. Klein übergeleitete Vorgänge, inklusive Mehrfach
vor_an_l <- vor_an_l %>% 
  mutate(bruttoLead = ifelse(duplicated(VorgangsNummer),0,1))


