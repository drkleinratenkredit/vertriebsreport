#--------------------------------
# Joinen und Kennzahlen ermitteln
#--------------------------------

# Zusammenfassung der Vorgänge und (Teil)Anträge zu einem Dataset
vor_an <- full_join(vorgang, antrag, by = "VorgangsNummer")

<<<<<<< HEAD
ds2 <- left_join(ds1, baustein, by = "AntragsNummer")
=======
vor_an_l <- left_join(vorgang, antrag, by = "VorgangsNummer")

# An Dr. Klein übergeleitete Vorgänge, inklusive Mehrfach
vor_an_l <- vor_an_l %>% 
  mutate(bruttoLead = ifelse(duplicated(VorgangsNummer),0,1))
>>>>>>> 305fdef56a8f7a259628e01251328c2192de9c77


