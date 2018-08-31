"# vertriebsreport" 
Grundlage für den Code sind die HOM36 Dateien

Folgende Kennzahlen müssen ermittelt und ausgewiesen werden:

- Anzahl aller Überleitungen

- Anzahl aller Überleitungen ohne doppelte Kunden

- Anzahl an "gewollten" Überleitungen von Coba an Dr. Klein

- Anzahl Kunden mit Angebot

- Anzahl eingereichter Angebote

- Anzahl aller Sales


Status in der Datei Teilanträge

Die Variable 'Status' hat die Werte:
1 ABGELEHNT_PRODUKTANBIETER

2 BEANTRAGT_ANTRAGSTELLER

3 NICHT_ANGENOMMEN_ANTRAGSTELLER

4 UNTERSCHRIEBEN_ANTRAGSTELLER

5 UNTERSCHRIEBEN_BEIDE

6 UNTERSCHRIEBEN_PRODUKTANBIETER

7 WIDERRUFEN_ANTRAGSTELLER

8 ZURUECKGESTELLT_PRODUKTANBIETER


Für die Aufnahme des jeweiligen Statusdatums gibt es folgende Felder
                                                      Reihenfolge höchster Status
1 AntragBeantragtAntragstellerAmDatum                 1            

2 AntragNichtAngenommenAntragstellerAmDatum           2

3 AntragWiderrufenAntragstellerAmDatum                8

4 AntragUnterschriebenAntragstellerAmDatum            3

5 AntragUnterschriebenBeideAmDatum                    6

6 AntragUnterschriebenBeideUnbestaetigtAmDatum                    (wird nicht verwendet; logischer Datentyp)

7 AntragUnterschriebenProduktanbieterAmDatum          5

8 AntragAbgelehntProduktanbieterAmDatum               7

9 AntragZurueckgestelltProduktanbieterAmDatum         4


Beobachtungen
Wenn der 'Status' 'ABGELEHNT_PRODIKTANBIETER' ist und im Feld 'AntragAbgelehntProduktanbieterAmDatum'
kein Datum vorhanden ist, dann wurde die Anfrage in der Vorprüfung abgelehnt und zwar am Datum, das
im Feld 'AntragBeantragtAntragstellerAmDatum' eingetragen ist
