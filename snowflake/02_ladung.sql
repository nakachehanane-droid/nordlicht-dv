use role accountadmin;
use warehouse lern_wh;
use schema raw.shop;

create file format if not exists csv_semikolon
type=csv
field_delimiter=';'
skip_header=1
encoding='utf8'
null_if=('');

create stage if not exists shop_stage
file_format=(format_name = 'csv_semikolon')
comment='hier sind unsere Dateien abgelegt';

copy into kunden
from (
  select $1, $2,$3,$4,$5,$6,$7,$8, current_timestamp()::timestamp_ntz, metadata$filename
  from @shop_stage/ladung_1/
)
files = ('kunden.csv');

copy into produkte
from (
  select $1, $2,$3,$4, current_timestamp()::timestamp_ntz, metadata$filename
  from @shop_stage/ladung_1/
)
files = ('produkte.csv');

copy into bestellungen
from (
  select $1, $2,$3,$4,current_timestamp()::timestamp_ntz, metadata$filename
  from @shop_stage/ladung_1/
)
files = ('bestellungen.csv');

copy into bestellpositionen
from (
  select $1, $2,$3,$4,$5,current_timestamp()::timestamp_ntz, metadata$filename
  from @shop_stage/ladung_1/
)
files = ('bestellpositionen.csv');