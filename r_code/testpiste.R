
write.table(antrag,paste0(getwd(),"/output/antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(antrag_vorgang,paste0(getwd(),"/output/antrag_vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vorgang_antrag,paste0(getwd(),"/output/vorgang_antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vorgang_antrag_FJ_,paste0(getwd(),"/output/vorgang_antrag_FJ_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vorgang,paste0(getwd(),"/output/vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)
