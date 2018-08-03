#Verschickliste erstellen

report <- antrag %>% 
  filter(AntragBeantragtAntragstellerAmDatum > "2017-12-31")  
  
 
write.xlsx(report,
           file = paste0(getwd(),"/output/report",Sys.Date(),".xlsx"))

pfad = paste0(getwd(),"/output/report.txt")
write.table(report,file = pfad,sep = "\t", append = FALSE, eol = "\n")

