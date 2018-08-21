
write.xlsx(mehrfach,paste0(getwd(),"/output/mehrfach.xlsx"))

write.csv(mehrfach,paste0(getwd(),"/output/mehrfach.csv"), quote = FALSE)

write.xlsx(antrag,paste0(getwd(),"/output/antrag.xlsx"))

write.csv(antrag,paste0(getwd(),"/output/antrag.csv"), quote = FALSE)

a <- NA
b <- as_date("2018-08-15")
c <- as_date("2018-08-8")
