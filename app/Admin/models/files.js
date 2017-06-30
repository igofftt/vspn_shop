import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'files',

		{
			active: Datatypes.INTEGER,

			created_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			crop: Datatypes.TEXT,

			deleted_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			description: Datatypes.TEXT,
			file       : Datatypes.STRING(128),

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			id_album  : Datatypes.INTEGER,
			keywords  : Datatypes.TEXT,
			main      : Datatypes.INTEGER,
			name      : Datatypes.STRING(50),
			name_table: Datatypes.STRING(50),
			orig_name : Datatypes.STRING(128),
			size      : Datatypes.STRING,
			sort      : Datatypes.INTEGER,
			text      : Datatypes.TEXT,
			title     : Datatypes.STRING(512),
			type      : Datatypes.STRING(128),

			updated_at: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'files',
			timestamps     : false,
			underscored    : true,
		});
};

// CREATE TABLE files (
// 	id serial PRIMARY KEY,
// 	name varchar(512),
// 	text text,
// 	title varchar(512),
// 	description text,
// 	keywords varchar(512),
// 	id_album integer,
// 	size varchar NOT NULL,
// 	sort integer,
// 	main integer,
// 	orig_name varchar(128) NOT NULL,
// 	type varchar(128) NOT NULL,
// 	file varchar(128) NOT NULL,
// 	name_table varchar(32),
// 	crop text,
// 	active integer NOT NULL DEFAULT '1',
// 	created_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL
// );
