#-------------------
# Tabellen vermengen
#-------------------

# ds1 <- inner_join(antrag, vorgang, by = "VorgangsNummer")

# ds2 <- left_join(ds1, baustein, by = )


ds_v_a <- inner_join(vorgang, antrag, by = "VorgangsNummer")



glimpse(ds1)
