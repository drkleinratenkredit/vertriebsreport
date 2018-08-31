
vorgaenge <- fread(paste0(getwd(),"/data/vorgaenge.csv"),encoding="UTF-8")
teilantraege <- fread(paste0(getwd(),"/data/teilantraege.csv"),encoding="UTF-8")
bausteine <- fread(paste0(getwd(),"/data/bausteine.csv"),encoding="UTF-8")
provisionen <- fread(paste0(getwd(),"/data/provisionen.csv"),encoding="UTF-8")
filialen <- read.xlsx(paste0(getwd(),"/data/Filialstruktur_Coba.xlsx"),sheetIndex = 1,encoding="UTF-8")
