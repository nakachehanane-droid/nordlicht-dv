{{ config(materialized='incremental',unique_key='hk_bestellpositionen') }}
with erstes_auftreten as (
    select hk_bestellpositionen,hk_bestellungen,hk_produkte,position,ladedatum,datenquelle
from {{ ref('dvs_bestellpositionen')}}
qualify row_number() over (partition by hk_bestellpositionen order by ladedatum) = 1
)
select * from erstes_auftreten
{% if is_incremental() %}
where hk_bestellpositionen not in (select hk_bestellpositionen from {{ this }})
{% endif %}
