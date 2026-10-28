{{ config(materialized='table') }}

select
    s.hk_kunden,
    h.kunden_nr,
    s.vorname,
    s.nachname,
    s.stadt,
   case 
   when lag(s.ladedatum) over (partition by s.hk_kunden order by s.ladedatum) is null then '1900-01-01'::timestamp_ntz 
   else s.ladedatum 
   end as gueltig_von,
    coalesce(
        lead(s.ladedatum) over (partition by s.hk_kunden order by s.ladedatum),
        '9999-12-31'::timestamp_ntz
    ) as gueltig_bis,
    case
        when lead(s.ladedatum) over (partition by s.hk_kunden order by s.ladedatum) is null then true
        else false
    end as ist_aktuell
from {{ ref('sat_kunden') }} s
join {{ ref('hub_kunden') }} h on s.hk_kunden = h.hk_kunden