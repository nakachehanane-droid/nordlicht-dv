{{ config(severity = 'warn') }}

select *
from {{ ref('sat_bestellpositionen') }}
where menge <= 0