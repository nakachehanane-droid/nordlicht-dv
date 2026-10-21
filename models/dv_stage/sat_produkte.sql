{{ config(materialized='table') }}

with quelle as (

    select
        hk_produkte,
        hd_produkte,
        ladedatum,
        datenquelle,
        produktname,
		kategorie,
		preis
    from {{ ref('dvs_produkte') }}

),

mit_vorgaenger as (

    select
        *,
        lag(hd_produkte) over (partition by hk_produkte order by ladedatum) as hd_vorher
    from quelle

)

select
    hk_produkte,
    ladedatum,
    hd_produkte,
    datenquelle,
    produktname,
	kategorie,
	preis
from mit_vorgaenger
where hd_vorher is null
   or hd_produkte <> hd_vorher