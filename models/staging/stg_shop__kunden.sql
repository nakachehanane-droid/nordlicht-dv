with quelle as (
    select * from {{source ('shop','kunden')}}
),
bereinigt as (
    select
    upper(trim(kunden_nr)) as kunden_nr,
    trim(vorname) as vorname,
    trim(nachname) as nachname,
    lower(trim(email)) as email,
    trim(strasse) as strasse,
    trim(plz) as plz,
    trim(stadt) as stadt,
    try_cast(registriert_am as date) as registriert_am,
    _geladen_am as ladedatum,
    _quelldatei as datenquelle
    from quelle
)
select * from bereinigt