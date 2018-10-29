#--------------------------------------------
# Joinen, Kennzahlen ermitteln und ausliefern
#--------------------------------------------

ds <- left_join(vorgang,antrag,by = "VorgangsNummer")

# Sortierung nach Statusrang
ds <- arrange(ds, desc(Statusrang))

# Kennzeichnung Mehrfachvorgangsnummern
ds <- ds %>% 
  mutate(vorgangsnummer_mehrfach = ifelse(duplicated(VorgangsNummer),1,0)) %>% 
  filter(vorgangsnummer_mehrfach == 0 | Statusrang == 8 | Statusrang == 7)

# Kennzahlen erzeugen
dataset <- ds %>% 
  mutate(ablehnungen_ohne_doppelte = ifelse(einfach_Kunde == 1,1,0),
         ist_drk_bearbeitet = ifelse((!is.na(AntragsNummer) | KundenbetreuerName == "in the Field, Martin"),1,0),
         ist_angebot_erstellt = ifelse(Statusrang > 1,1,0),
         ist_angebot_eingereicht = ifelse(Statusrang > 3 & DSL_hat_storniert == 0,1,0),
         ist_sale = ifelse(Statusrang == 7 | Statusrang == 8,1,0),
         salevolumen = ifelse(Statusrang == 7 | Statusrang == 8,AuszahlungsBetrag,0),
         ist_manuell_angelegt = ifelse(EigeneVorgangsNummerDesVertriebs == "",1,0),
         ist_in_vorpruefung_abgelehnt = ifelse(Statusrang == 1,1,0),
         ist_abschliessend_abgelehnt = ifelse(Statusrang == 6,1,0),
         ablehnungsvolumen = ifelse(Statusrang == 6, AuszahlungsBetrag,0),
         antragsvolumen = (ifelse(Statusrang > 3 & DSL_hat_storniert == 0, AuszahlungsBetrag,0)) - salevolumen - ablehnungsvolumen,
         angebotsvolumen = (ifelse(Statusrang > 1,AuszahlungsBetrag,0)) - antragsvolumen - ablehnungsvolumen - salevolumen
         
  )

# Für das Coba Dataset werden die MA verwischt und die erforderlichen Spalten selektiert
ds_coba <- dataset %>%
  mutate(AuswertungsEbene3Ep2PartnerName = "",
         KundenbetreuerName = "",
         BearbeiterPartnerName = "")

ds_coba <- ds_coba %>% 
  select(VorgangsNummer, VorgangAngelegtAmDatum, EigeneVorgangsNummerDesVertriebs, Antragsteller1Vorname,
         Antragsteller1Nachname, Antragsteller1Geburtsdatum, Antragsteller2Vorname, Antragsteller2Nachname,
         Antragsteller2Geburtsdatum, Verwendungszweck, TippgeberExternePartnerId, coba_hat_abgelehnt,
         FilHB, angelegt_Jahr, angelegt_Monat, angelegt_Monatname, angelegt_Tag, angelegt_WTag,
         mehrfach_Kunde, ist_mehrfach_Kunde, einfach_Kunde, Filiale, Niederlassung, Marktregion,
         AntragsNummer, ExterneVorgangsNummerDesProduktAnbieters, AntragBeantragtAntragstellerAmDatum,
         AntragNichtAngenommenAntragstellerAmDatum, AntragWiderrufenAntragstellerAmDatum,
         AntragUnterschriebenAntragstellerAmDatum, AntragUnterschriebenBeideAmDatum, AntragUnterschriebenProduktanbieterAmDatum,
         AntragAbgelehntProduktanbieterAmDatum, AntragZurueckgestelltProduktanbieterAmDatum,
         ProduktAnbieterId, AntragAutomatischAbgelehnt, StatusVonDatum, AuszahlungsBetrag, Status_neu,
         status_Jahr, status_Monat, status_Monatname, status_Tag, status_WTag, vorgangsnummer_mehrfach,
         ablehnungen_ohne_doppelte, ist_drk_bearbeitet, ist_angebot_erstellt, ist_angebot_eingereicht,
         ist_sale, salevolumen)


write.table(ds_coba,paste0(getwd(),"/output/ds_coba.txt"),sep = "\t",row.names = FALSE)

# Dataset für den RK Vertrieb
dataset <- dataset %>%
  mutate(BausteinArt = as.character(BausteinArt),
         ist_ratenschutz = ifelse(!is.na(BausteinArt),1,0))

write.table(dataset,paste0(getwd(),"/output/ds_rk.txt"),sep = "\t",row.names = FALSE)

print("Fertig")
