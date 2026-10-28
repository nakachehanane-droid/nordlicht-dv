select
    k.stadt,
    count(distinct f.hk_kunden) as anzahl_kunden,
    sum(f.umsatz_eur)           as umsatz
from {{ ref('fct_bestellpositionen') }} f
join {{ ref('dim_kunden_historie') }} k
    on  f.hk_kunden = k.hk_kunden
    and f.bestelldatum >= k.gueltig_von
    and f.bestelldatum <  k.gueltig_bis
group by k.stadt
order by umsatz desc
limit 10