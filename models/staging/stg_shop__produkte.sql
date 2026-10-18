with quelle as (
    select * from {{source('shop','produkte')}}
)
,breinigt as(
  select trim(produkt_nr) as produkt_nr,
        upper(trim(produktname)) as produktname,
        upper(trim(kategorie)) as kategorie,
        try_cast(trim(listenpreis_eur) as number(10,2)) as preis,
        _geladen_am as ladedatum,
        _quelldatei as datenquelle
        from quelle
)
select * from breinigt