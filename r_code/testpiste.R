
write.xlsx(mehrfach,paste0(getwd(),"/output/mehrfach.xlsx"))

write.csv(mehrfach,paste0(getwd(),"/output/mehrfach.csv"), quote = FALSE)


write.table(antrag,paste0(getwd(),"/output/antrag",Sys.Date(),".txt"), sep = "\t", row.names = FALSE)

write.table(vorgang,paste0(getwd(),"/output/vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(ds1,paste0(getwd(),"/output/antrag_vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)
