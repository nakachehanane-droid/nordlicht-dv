{{ config(materialized='table') }}
select hk_kunden,kunden_nr,ladedatum,datenquelle
from {{ ref('dvs_kunden')}}
qualify row_number() over (partition by hk_kunden order by ladedatum) = 1