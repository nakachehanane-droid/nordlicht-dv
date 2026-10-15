# Nordlicht – Data Vault mit Snowflake und dbt

Lernprojekt: Ich baue ein Data Warehouse für den fiktiven Möbel-Onlineshop
„NordLicht Wohnen“. Die Rohdaten werden als Data Vault 2.0 modelliert und
daraus ein Star-Schema für Auswertungen erstellt.

## Werkzeuge

- **Git** – Versionsverwaltung: speichert jede Änderung am Projekt
- **GitHub** – Speicherort des Projekts im Internet, Arbeit mit Pull Requests
- **Snowflake** – Cloud-Datenbank: speichert die Daten und führt die Berechnungen aus
- **dbt** – Transformation: schreibt die Modelle als SQL und baut sie in Snowflake auf

## Aufbau

Die Daten kommen als CSV-Dateien. Sie werden über eine Stage in die
RAW-Datenbank in Snowflake geladen. dbt wandelt sie anschließend direkt in
Snowflake um (ELT) und legt das Ergebnis in der Datenbank ANALYTICS ab:

1. **Staging** – Daten bereinigen und Datentypen setzen
2. **Raw Vault** – Hubs (Geschäftsschlüssel), Links (Beziehungen) und
   Satellites (Attribute mit Historie)
3. **Marts** – Star-Schema mit Dimensionen und Fakten für Auswertungen

## Status

- [x] Projekt und Git-Repository angelegt
- [ ] Snowflake einrichten
- [ ] Daten laden
- [ ] dbt-Projekt aufbauen