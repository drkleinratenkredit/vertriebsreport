
write.table(vorgang,paste0(getwd(),"/output/vorgang_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(antrag,paste0(getwd(),"/output/antrag_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(antrag_einfach,paste0(getwd(),"/output/antrag_einfach_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vorgang_antrag,paste0(getwd(),"/output/vorgang_antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(ds9,paste0(getwd(),"/output/ds9_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(dataset,paste0(getwd(),"/output/dataset_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(dataset_einfach,paste0(getwd(),"/output/dataset_einfach_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)


                               