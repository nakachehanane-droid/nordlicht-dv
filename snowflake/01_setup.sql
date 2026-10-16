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
------------Database--------
create database if not exists raw;
create database if not exists analytics;
create schema if not exists raw.shop;
grant usage on database raw to role transformer;
grant usage on schema raw.shop to role transformer;
grant select on all tables in schema raw.shop to role transformer;
grant select on future tables in schema raw.shop to role transformer;
grant ownership on database analytics to role transformer;