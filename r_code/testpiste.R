
write.table(vorgang,paste0(getwd(),"/output/vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(antrag,paste0(getwd(),"/output/antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vorgang_antrag,paste0(getwd(),"/output/vorgang_antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(ds1,paste0(getwd(),"/output/ds1_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)




