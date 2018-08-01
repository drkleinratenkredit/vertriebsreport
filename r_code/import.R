
teilantraege <- fread(paste0(getwd(),"/data/Teilantraege_HOM36.csv"))
vorgaenge <- fread(paste0(getwd(),"/data/Vorgaenge_HOM36.csv"))
filialen <- read.xlsx(paste0(getwd(),"/data/Filialstruktur_Coba.xlsx"),sheetIndex = 1)
