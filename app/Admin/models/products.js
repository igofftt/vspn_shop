import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'products',

		{
			active: Datatypes.INTEGER,
			author: Datatypes.STRING(64),
			brand : Datatypes.INTEGER,
			cat   : Datatypes.INTEGER,

			created_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			deleted_at: {
				field: 'deleted_at',
				type : Sequelize.DATE,
			},

			description: Datatypes.STRING(512),
			discount   : Datatypes.INTEGER,
			html_bottom: Datatypes.TEXT,
			html_top   : Datatypes.TEXT,

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			keywords: Datatypes.STRING(512),
			name    : Datatypes.STRING(512),
			params  : Datatypes.JSON,
			price   : Datatypes.INTEGER,
			sort    : Datatypes.INTEGER,
			tags    : Datatypes.STRING(512),
			text    : Datatypes.TEXT,
			title   : Datatypes.STRING(512),
			to_main : Datatypes.INTEGER,

			updated_at: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},

			user_id    : Datatypes.INTEGER,
			vendor_code: Datatypes.STRING,
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'products',
			timestamps     : true,
			underscored    : true,
		});
};

// CREATE TABLE products (
// id serial PRIMARY KEY,
// 	author varchar(64),
// 	name varchar(512) NOT NULL,
// 	html_bottom text,
// 	html_top text,
// 	keywords varchar(512),
// 	active integer NOT NULL DEFAULT '1',
// 	cat integer,
// 	sort integer,
// 	tags varchar(512),
// 	text text,
// 	title varchar(512),
// 	to_main integer,
// 	description varchar(512),
// 	params json,
// 	price integer,
// 	vendor_code varchar(64),
// 	created_at timestamp NULL DEFAULT NULL,
// 	deleted_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL
// );



