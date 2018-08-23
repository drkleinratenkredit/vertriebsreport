#-------------------
# Tabellen vermengen
#-------------------

ds1 <- inner_join(antrag, vorgang, by = "VorgangsNummer")



glimpse(ds1)
