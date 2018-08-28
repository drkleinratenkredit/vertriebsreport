#--------------------------------
# Joinen und Kennzahlen ermitteln
#--------------------------------

vorgang_antrag <- left_join(vorgang,antrag, by = "VorgangsNummer")

dataset <- group_by(vorgang_antrag, VorgangsNummer)

dataset2 <- summarize(dataset, Statusrang = max(Statusrang))
 


dataset3 <- as.data.table(union(dataset, dataset2))


