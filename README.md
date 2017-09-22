# Duzzer
Duzzer shop

## For start
###### PostgreSql
`sudo apt install postgresql`
`su postgres` <br />
`psql -U postgres -p5433` <br />
`DROP DATABASE "duzzer_1";` <br />
`CREATE DATABASE "duzzer_1";` !!Only for a complete reinstallation!! <br />
`\q` <br />
`psql -p5432 -U postgres duzzer_1 < duzzer_1.sql`  <br />

###### NodeJs Daemon
`npm i -g pm2`<br />

###### For images
`apt install imagemagick`<br />
`apt install graphicsmagick`
###### Create .env
`touch /var/www/duzzer/.env`


_Open to edit file_<br />

`DB_NAME=duzzer_1`<br />
`DB_HOST=localhost`<br />
`DB_USER=pgadmin`<br />
`DB_PASS=pass`<br />
`DB_PORT=5433`<br />
`DB_MAXC=10`<br />
`DB_ITM=600000`<br />
`NODE_ENV=dev`<br />
`ADMIN_USER=admin`<br />
`ADMIN_PASS=1234`<br />
`NODE_PATH=/app`<br />

#### Start server
`cd /var/www/duzzer/`<br />
`pm2 start node_modules/gulp/bin/gulp.js`

#### Create local dump
`sudo pg_dump -p5432 -U postgres duzzer_1 > duzzer_1.sql` 
#### Delete db & restore dump
`su postgres` <br />
`psql -U postgres -p5433` <br />
`DROP DATABASE "duzzer_1";` <br />
`CREATE DATABASE "duzzer_1";` <br />
`\q` <br />
`psql -p5432 -U postgres duzzer_1 < duzzer_1.sql`  <br />
