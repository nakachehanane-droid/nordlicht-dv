{{ config(materialized='incremental',unique_key='hk_kunden_bestellung') }}
with erstes_auftreten as (
    select hk_kunden_bestellung,hk_kunden,hk_bestellungen,ladedatum,datenquelle
from {{ ref('dvs_bestellungen')}}
qualify row_number() over (partition by hk_kunden_bestellung order by ladedatum) = 1
)
select * from erstes_auftreten
{% if is_incremental() %}
where hk_kunden_bestellung not in (select hk_kunden_bestellung from {{ this }})
{% endif %}
