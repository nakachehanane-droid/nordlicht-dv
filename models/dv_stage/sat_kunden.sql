{{ config(materialized='table') }}

with quelle as (

    select
        hk_kunden,
        hd_kunden,
        ladedatum,
        datenquelle,
        vorname,
        nachname,
        email,
        strasse,
        plz,
        stadt,
        registriert_am
    from {{ ref('dvs_kunden') }}

),

mit_vorgaenger as (

    select
        *,
        lag(hd_kunden) over (partition by hk_kunden order by ladedatum) as hd_vorher
    from quelle

)

select
    hk_kunden,
    ladedatum,
    hd_kunden,
    datenquelle,
    vorname,
    nachname,
    email,
    strasse,
    plz,
    stadt,
    registriert_am
from mit_vorgaenger
where hd_vorher is null
   or hd_kunden <> hd_vorher