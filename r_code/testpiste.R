
write.table(vorgang,paste0(getwd(),"/output/vorgang",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(antrag,paste0(getwd(),"/output/antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vorgang_antrag,paste0(getwd(),"/output/vorgang_antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(ds0,paste0(getwd(),"/output/ds0_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(ds1,paste0(getwd(),"/output/ds1_",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)


a <- as_date("2018-08-22")

b <- day(a)
c <- wday(a,label = TRUE)
d <- month(a)
e <- paste0("Wochentag ",c)
