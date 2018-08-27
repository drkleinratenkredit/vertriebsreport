#-------------------
# Tabellen vermengen
#-------------------

ds1 <- inner_join(antrag, vorgang, by = "VorgangsNummer")

ds2 <- left_join(ds1, baustein, by = "AntragsNummer")


glimpse(ds1)
