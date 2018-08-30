#--------------------------------
# Joinen und Kennzahlen ermitteln
#--------------------------------
#######################Lösung 2018-08-30#######################################
vorgang_antrag <- left_join(vorgang,antrag, by = "VorgangsNummer")

vorgang_antrag <- vorgang_antrag %>% 
  mutate(Statusrang = ifelse(is.na(Statusrang),0,Statusrang))

# Die datensätze werden nach dem Statusrang sortiert (der Höchste zuerst)
dataset <- arrange(dataset, desc(Statusrang))

# Jetzt werden die Vorgangsnummern nach Mehrfach gekennzeichnet
dataset5 <- dataset %>% 
  mutate(mf_Vorgang = duplicated(VorgangsNummer))

# Mehrfach wird heraus genommen
dataset6 <- dataset5 %>% 
  filter(mf_Vorgang == FALSE)

#################################################################################

dataset2 <- summarize(dataset, Statusrang = max(Statusrang))

antrag_grouped <- group_by(antrag, VorgangsNummer)

antrag_grouped_s <- summarize(antrag_grouped, Statusrang = max(Statusrang))




dataset <- group_by(vorgang_antrag, VorgangsNummer) %>% 
  filter(Statusrang == max(Statusrang))

glimpse(antrag)
