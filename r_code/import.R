
vorgaenge <- fread(paste0(getwd(),"/data/vorgaenge.csv"))
teilantraege <- fread(paste0(getwd(),"/data/teilantraege.csv"))
bausteine <- fread(paste0(getwd(),"/data/bausteine.csv"))
provisionen <- fread(paste0(getwd(),"/data/provisionen.csv"))
filialen <- read.xlsx(paste0(getwd(),"/data/Filialstruktur_Coba.xlsx"),sheetIndex = 1)
