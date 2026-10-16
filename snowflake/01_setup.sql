use role accountadmin;
--------warehouse---------
create warehouse if not exists lern_wh
warehouse_size='xsmall'
auto_suspend=60
auto_resume=true
initially_suspended=true;
--------Rolle----------
create role if not exists transformer;
grant usage on warehouse lern_wh to role transformer;
grant role transformer to user HANANE1984;
grant role transformer to role sysadmin;

