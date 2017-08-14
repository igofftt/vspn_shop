# vspn_shop
VSPN shop

sudo pg_dump -p5432 -U postgres duzzer_1 > duzzer_1.sql 

su postgres
DROP DATABASE "duzzer_1";
CREATE DATABASE "duzzer_1";
\q
sudo psql -p5433 -U postgres duzzer_1 < duzzer_1.sql 
