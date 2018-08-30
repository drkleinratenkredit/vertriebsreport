#--------------------------------
# Joinen und Kennzahlen ermitteln
#--------------------------------
#######################Lösung 2018-08-30#######################################
vorgang_antrag <- left_join(vorgang,antrag, by = "VorgangsNummer")

vorgang_antrag <- vorgang_antrag %>% 
  mutate(Statusrang = as.integer((ifelse(is.na(Statusrang),0,Statusrang))))

 # Die Datensätze werden nach dem Statusrang sortiert (der Höchste zuerst)
dataset <- arrange(dataset, desc(Statusrang))

# Jetzt werden die Vorgangsnummern nach Mehrfach gekennzeichnet
dataset5 <- dataset %>% 
  mutate(mf_Vorgang = duplicated(VorgangsNummer))

# Mehrfach wird heraus genommen
dataset6 <- dataset5 %>% 
  filter((mf_Vorgang == FALSE) & (Status_neu == "UNTERSCHRIEBEN_BEIDE"))


# Untersuchung der Beobachtungen, die heraus gefallen sind
dataset7 <- dataset5 %>% 
  filter(mf_Vorgang == TRUE)



#################################################################################

################Neuer Ansatz - Einzelermittlung der Kennzahlen###################
ds1 <- vorgang_antrag %>% 
  mutate(istSale = ifelse(Status_neu == "UNTERSCHRIEBEN_BEIDE",1,0),
         ist_mehrfach_Vorgangsnummer = ifelse(duplicated(VorgangsNummer),1,0),
         Sale_Volumen = ifelse(Status_neu == "UNTERSCHRIEBEN_BEIDE",SummeFinanzierungswunschOhneZwifi,0),
         istEingereicht = ifelse((Status_neu == "WIDERRUFEN_ANTRAGSTELLER") | 
                                   (Status_neu == "ABGELEHNT_PRODUKTANBIETER") |
                                   (Status_neu == "UNTERSCHRIEBEN_BEIDE") |
                                   (Status_neu == "UNTERSCHRIEBEN_PRODUKTANBIETER") |
                                   (Status_neu == "ZURUECKGESTELLT_PRODUKTANBIETER"),1,0),
         eingereicht_Volumen = ifelse((Status_neu == "WIDERRUFEN_ANTRAGSTELLER") | 
                                   (Status_neu == "ABGELEHNT_PRODUKTANBIETER") |
                                   (Status_neu == "UNTERSCHRIEBEN_BEIDE") |
                                   (Status_neu == "UNTERSCHRIEBEN_PRODUKTANBIETER") |
                                   (Status_neu == "ZURUECKGESTELLT_PRODUKTANBIETER"),SummeFinanzierungswunschOhneZwifi,0))
                                   







dataset2 <- summarize(dataset, Statusrang = max(Statusrang))

antrag_grouped <- group_by(antrag, VorgangsNummer)

antrag_grouped_s <- summarize(antrag_grouped, Statusrang = max(Statusrang))

dataset <- group_by(vorgang_antrag, VorgangsNummer) %>% 
  filter(Statusrang == max(Statusrang))

glimpse(antrag)
