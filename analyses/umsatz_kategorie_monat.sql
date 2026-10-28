select
    date_trunc('month', f.bestelldatum) as monat,
    p.kategorie                                 as kategorie,
    sum(f.umsatz_eur )                              as umsatz_eur
from {{ ref('fct_bestellpositionen') }} f
join {{ref('dim_produkte')}} p on f.hk_produkte=p.hk_produkte
group by monat,kategorie
order by monat,kategorie