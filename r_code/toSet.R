#--------------------------------
# Joinen und Kennzahlen ermitteln
#--------------------------------

# Zusammenfassung der Vorgänge und (Teil)Anträge zu einem Dataset
vor_an <- left_join(vorgang, antrag, by = "VorgangsNummer")

# An Dr. Klein übergeleitete Vorgänge, inklusive Mehrfach


