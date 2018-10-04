
vorgaenge <- fread(paste0(getwd(),"/data/Vorgaenge_HOM36.csv"),encoding="UTF-8")
teilantraege <- fread(paste0(getwd(),"/data/Teilantraege_HOM36.csv"),encoding="UTF-8")
bausteine <- fread(paste0(getwd(),"/data/Bausteine_HOM36.csv"),encoding="UTF-8")
provisionen <- fread(paste0(getwd(),"/data/Provisionen_HOM36.csv"),encoding="UTF-8")
filialen <- read.xlsx(paste0(getwd(),"/data/Filialstruktur_Coba.xlsx"),sheetIndex = 1,encoding="UTF-8")
