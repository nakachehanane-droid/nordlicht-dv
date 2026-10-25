{{ config(materialized='table') }}

with aktueller_stand as (

    select hk_kunden, vorname, nachname, email, strasse, plz, stadt, registriert_am
    from {{ ref('sat_kunden') }}
    qualify row_number() over (partition by hk_kunden order by ladedatum desc) = 1

)

select
    h.hk_kunden,
    h.kunden_nr,
    s.vorname,
    s.nachname,
    s.vorname || ' ' || s.nachname   as kundenname,
    s.email,
    s.strasse,
    s.plz,
    s.stadt,
    s.registriert_am
from {{ ref('hub_kunden') }} h
join aktueller_stand s on h.hk_kunden = s.hk_kunden