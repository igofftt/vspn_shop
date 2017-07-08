import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'menu',

		{
			active    : Datatypes.INTEGER,
			album     : Datatypes.INTEGER,
			author    : Datatypes.STRING(128),
			cat       : Datatypes.INTEGER,
			class     : Datatypes.STRING(32),
			controller: Datatypes.STRING(32),

			created_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},
			deleted_at: {
				field: 'deleted_at',
				type : Sequelize.DATE,
			},

			description: Datatypes.STRING(512),
			fields_land: Datatypes.INTEGER,

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			keywords: Datatypes.STRING(512),
			name    : Datatypes.STRING(512),
			sort    : Datatypes.INTEGER,
			sys_cat : Datatypes.STRING(32),
			text    : Datatypes.TEXT,
			title   : Datatypes.STRING(512),

			updated_at: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'menu',
			timestamps     : true,
			underscored    : true,
		});
};

// CREATE TABLE menu (
// 	id serial PRIMARY KEY,
// 	name varchar(512) NOT NULL,
// 	sys_cat varchar(32),
// 	text text,
// 	active integer NOT NULL DEFAULT '1',
// 	cat integer DEFAULT '0',
// 	title varchar(512),
// 	author varchar(128),
// 	keywords varchar(512),
// 	description varchar(512),
// 	sort integer DEFAULT '0',
// 	class varchar(32),
// 	controller varchar(32),
// 	album integer,
// 	fields_land integer,
// 	created_at timestamp NULL DEFAULT NULL,
// 	deleted_at  timestamp NULL DEFAULT NULL,
// 	updated_at  timestamp NULL DEFAULT NULL
// );