
write.table(vor_an_l,paste0(getwd(),"/output/vor_an_l",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)

write.table(vor_an,paste0(getwd(),"/output/vorgang_antrag",Sys.Date(),".txt"),sep = "\t",row.names = FALSE)


# letzte Stelle eines Strings feststellen

a <- "jdfj/1"

b <- str_sub(a, -1)
if(b == "1") c <- "Vorgang" else c <- "mf"


