{{ config(materialized='table') }}

with aktueller_stand as (
select hk_produkte,produktname,
	kategorie,
	preis
	from {{ref('sat_produkte')}}
	qualify row_number() over (partition by hk_produkte order by ladedatum desc) = 1
	)
select 
    p.hk_produkte,p.produkt_nr,s.produktname,s.kategorie,s.preis as listenpreis_eur

from {{ ref('hub_produkte') }} p
join aktueller_stand s on p.hk_produkte=s.hk_produkte	
	