
write.table(antrag,paste0(getwd(),"/output/antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(antrag_grouped,paste0(getwd(),"/output/antrag_grouped",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vorgang_antrag,paste0(getwd(),"/output/vorgang_antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vorgang_antrag_FJ_,paste0(getwd(),"/output/vorgang_antrag_FJ_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vorgang,paste0(getwd(),"/output/vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(dataset5,paste0(getwd(),"/output/dataset5",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(dataset6,paste0(getwd(),"/output/dataset6",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(dataset,paste0(getwd(),"/output/dataset",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)
