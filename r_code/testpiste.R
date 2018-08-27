
write.xlsx(mehrfach,paste0(getwd(),"/output/mehrfach.xlsx"))

write.csv(mehrfach,paste0(getwd(),"/output/mehrfach.csv"), quote = FALSE)


write.table(antrag,paste0(getwd(),"/output/antrag",Sys.Date(),".txt"), sep = "\t", row.names = FALSE)

write.table(vorgang,paste0(getwd(),"/output/vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(ds1,paste0(getwd(),"/output/antrag_vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

ds2 <- ds2 %>% 
  filter(VorgangAngelegtAmDatum > "2016-12-31")

write.table(ds2,paste0(getwd(),"/output/antrag_vorgang_baustein",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

dataset <- fread(paste0(getwd(),"/output/antrag_vorgang_baustein2018-08-23.txt"))

dataset <- read.xlsx(paste0(getwd(),"/output/antrag_vorgang_baustein2018-08-23.xlsx"),sheetIndex = 1)
