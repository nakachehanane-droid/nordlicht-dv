select k.stadt,count(distinct f.hk_kunden)as anzahl_kunden,sum(f.umsatz_eur) as umsatz
from {{ref('fct_bestellpositionen')}} f
join {{ref('dim_kunden')}} k on f.hk_kunden=k.hk_kunden
group by k.stadt
order by umsatz desc 
limit 10