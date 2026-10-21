
{{ config(materialized='incremental',unique_key='hk_bestellungen') }}
with erstes_auftreten as (
    select hk_bestellungen,bestell_nr,ladedatum,datenquelle
from {{ ref('dvs_bestellungen')}}
qualify row_number() over (partition by hk_bestellungen order by ladedatum) = 1
)
select * from erstes_auftreten
{% if is_incremental() %}
where hk_bestellungen not in (select hk_bestellungen from {{ this }})
{% endif %}
