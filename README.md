# dbt Assignment: AirStats Capstone Project

dbt project analyzing global airport data. Assigment from Udemy `The Complete dbt Bootcamp: Zero to Hero + Certification Prep`

## 1. Constraints

- sources są zdefiniowane wszystkie
- ale do zabawy bierzemy tylko 3 tabele:
  - airports
  - airport_comments
  - runways
- pozostałe modele **bronze** są zdefiniowane, ale maja `config(enabled=false)` i ich nazwa wyroznia sie **z_**<nazwa_modelu>