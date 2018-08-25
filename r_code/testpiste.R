
write.xlsx(mehrfach,paste0(getwd(),"/output/mehrfach.xlsx"))

write.csv(mehrfach,paste0(getwd(),"/output/mehrfach.csv"), quote = FALSE)


write.table(antrag,paste0(getwd(),"/output/antrag",Sys.Date(),".txt"), sep = "\t", row.names = FALSE)

write.table(vorgang,paste0(getwd(),"/output/vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(ds1,paste0(getwd(),"/output/antrag_vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(ds_v_a,paste0(getwd(),"/output/vorgang_antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(ds_v_a,paste0(getwd(),"/output/inner_vorgang_antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)


# letzte Stelle eines Strings feststellen

a <- "jdfj/1"

b <- str_sub(a, -1)
if(b == "1") c <- "Vorgang" else c <- "mf"


