{{ config(materialized='incremental',unique_key='hk_kunden') }}
with erstes_auftreten as (
    select hk_kunden,kunden_nr,ladedatum,datenquelle
from {{ ref('dvs_kunden')}}
qualify row_number() over (partition by hk_kunden order by ladedatum) = 1
)
select * from erstes_auftreten
{% if is_incremental() %}
where hk_kunden not in (select hk_kunden from {{ this }})
{% endif %}