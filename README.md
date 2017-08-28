# Duzzer
Duzzer shop

#### Create local dump
sudo pg_dump -p5432 -U postgres duzzer_1 > duzzer_1.sql 
#### Delete db & restore dump (only develop)
su postgres
psql -U postgres -p5433 <br />
DROP DATABASE "duzzer_1"; <br />
CREATE DATABASE "duzzer_1"; <br />
\q <br />
psql -p5433 -U postgres duzzer_1 < duzzer_1.sql  <br />


## Start server dev
cd /var/www/develop/duzzer/
forever start node_modules/gulp/bin/gulp.js
