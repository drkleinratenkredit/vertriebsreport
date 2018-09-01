#--------------------------------
# Joinen und Kennzahlen ermitteln
#--------------------------------

vorgang <- left_join(vorgang,filialen, by = "FilHB")

vorgang_antrag <- left_join(vorgang,antrag, by = "VorgangsNummer")

vorgang_antrag <- vorgang_antrag %>% 
  mutate(Statusrang = as.integer((ifelse(is.na(Statusrang),0,Statusrang))))

ds0 <- arrange(vorgang_antrag, desc(Statusrang))

ds1 <- ds0 %>% 
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
                                   (Status_neu == "ZURUECKGESTELLT_PRODUKTANBIETER"),SummeFinanzierungswunschOhneZwifi,0),
         anzahl_Kunden_mit_Angebot = ifelse(!is.na(AntragsNummer) & ist_mehrfach_Vorgangsnummer == 0 & istMehrfach == 0,1,0))

                                   







