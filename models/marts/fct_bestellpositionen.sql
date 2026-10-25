{{ config(materialized='table') }}

with position_aktuell as (

    select hk_bestellpositionen, menge, einzelpreis_eur
    from {{ ref('sat_bestellpositionen') }}
    qualify row_number() over (partition by hk_bestellpositionen order by ladedatum desc) = 1

),

bestellung_aktuell as (

    select hk_bestellungen, bestelldatum, status
    from {{ ref('sat_bestellungen') }}
    qualify row_number() over (partition by hk_bestellungen order by ladedatum desc) = 1

)

select
    lp.hk_bestellpositionen,
    lp.hk_produkte,
    lk.hk_kunden,
    hb.bestell_nr,
    ba.bestelldatum,
    ba.status,
    pa.menge,
    pa.einzelpreis_eur,
    pa.menge * pa.einzelpreis_eur      as umsatz_eur
from {{ ref('link_bestellpositionen') }} lp
join position_aktuell pa                     on lp.hk_bestellpositionen = pa.hk_bestellpositionen
join {{ ref('hub_bestellungen') }} hb        on lp.hk_bestellungen      = hb.hk_bestellungen
join bestellung_aktuell ba                   on lp.hk_bestellungen      = ba.hk_bestellungen
join {{ ref('link_kunden_bestellung') }} lk  on lp.hk_bestellungen      = lk.hk_bestellungen
where pa.menge > 0   