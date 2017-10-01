import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'characteristics',

		{
			active   : Datatypes.INTEGER,
			cat_multi: Datatypes.STRING(512),

			createdAt: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			deletedAt: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			measure         : Datatypes.STRING(512),
			name            : Datatypes.STRING(512),
			name_description: Datatypes.STRING(512),
			system_name     : Datatypes.STRING(512),

			updatedAt: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},

			value: Datatypes.TEXT,
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'characteristics',
			timestamps     : false,
		});
};

// CREATE TABLE characteristics (
// 	id serial PRIMARY KEY,
// 	active integer NOT NULL DEFAULT '1',
//  name varchar(512),
//  system_name varchar(512),
//  measure varchar(512),
//  cat_multi varchar(512),
// 	little_description text,
//  value varchar(512),
// 	created_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL
// );
