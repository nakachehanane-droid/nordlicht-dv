{{ config(materialized='table') }}

with quelle as (

    select
        hk_bestellpositionen,
        hd_bestellpositionen,
        ladedatum,
        datenquelle,
        menge,
        einzelpreis_eur
    from {{ ref('dvs_bestellpositionen') }}

),

mit_vorgaenger as (

    select
        *,
        lag(hd_bestellpositionen) over (partition by hk_bestellpositionen order by ladedatum) as hd_vorher
    from quelle

)

select
    hk_bestellpositionen,
    hd_bestellpositionen,
    ladedatum,
    datenquelle,
    menge,
    einzelpreis_eur
from mit_vorgaenger
where hd_vorher is null
   or hd_bestellpositionen <> hd_vorher