with quelle as(
    select * from {{source('shop','bestellpositionen')}}
)
,bereinigt as (
    select upper(trim(bestell_nr)) as bestell_nr,
           trim(position) as position,
           upper(trim(produkt_nr)) as produkt_nr,
           try_cast(trim(menge) as number) as menge,
           try_cast(trim(einzelpreis_eur) as number(10,2)) as einzelpreis_eur,
            _geladen_am as ladedatum,
            _quelldatei as datenquelle
        from quelle    
)
select * from bereinigt