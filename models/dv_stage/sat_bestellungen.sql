{{ config(materialized='table') }}

with quelle as (

    select
        hk_bestellungen,
        hd_bestellungen,
        ladedatum,
        datenquelle,
        bestelldatum,
		status
    from {{ ref('dvs_bestellungen') }}

),

mit_vorgaenger as (

    select
        *,
        lag(hd_bestellungen) over (partition by hk_bestellungen order by ladedatum) as hd_vorher
    from quelle

)

select
    hk_bestellungen,
    hd_bestellungen,
    ladedatum,
    datenquelle,
    bestelldatum,
    status
from mit_vorgaenger
where hd_vorher is null
   or hd_bestellungen <> hd_vorher
