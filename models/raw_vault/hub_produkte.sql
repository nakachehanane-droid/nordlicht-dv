{{ config(materialized='incremental',unique_key='hk_produkte') }}
with erstes_auftreten as (
    select hk_produkte,produkt_nr,ladedatum,datenquelle
from {{ ref('dvs_produkte')}}
qualify row_number() over (partition by hk_produkte order by ladedatum) = 1
)
select * from erstes_auftreten
{% if is_incremental() %}
where hk_produkte not in (select hk_produkte from {{ this }})
{% endif %}