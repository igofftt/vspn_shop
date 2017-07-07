import Sequelize from 'sequelize';
import pg from 'pg';
import dotenv from 'dotenv';

const
	env = dotenv.config();

let
	connectionString = `postgres://${env.parsed.DB_USER}@${env.parsed.DB_HOST}
  :${env.parsed.DB_PORT}/${env.parsed.DB_NAME}`;

if(env.parsed.DB_PASS)
	connectionString = `postgres://${env.parsed.DB_USER}:${env.parsed.DB_PASS}@${env.parsed.DB_HOST}:${env.parsed.DB_PORT}/${env.parsed.DB_NAME}`;

let
	db = {};

let
	config = {
		database         : process.env.DB_NAME,
		host             : process.env.DB_HOST,
		idleTimeoutMillis: process.env.DB_ITM,
		max              : process.env.DB_MAXC,
		password         : process.env.DB_PASS,
		port             : process.env.DB_PORT,
		user             : process.env.DB_USER,
	},
	pgPool = new pg.Pool(config);

pgPool.on('error', err => {
	console.error('db: idle client error', err.message, err.stack);
});

db = new Sequelize(connectionString, {logging: process.env.NODE_ENV === 'production' ? false : console.log});

// таблицы бд
db.userModel = db.import('./user');
db.filesModel = db.import('./files');
db.powerModel = db.import('./power');
db.productsModel = db.import('./products');
db.langModel = db.import('./lang');

// for querying sql
db.execute = (text, values) => pgPool.query(text, values);
export default db;
