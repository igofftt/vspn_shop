import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'brand',

		{
			active: Datatypes.INTEGER,
			cat   : Datatypes.INTEGER,

			created_at: {
				field: 'createdat',
				type : Sequelize.DATE,
			},

			deleted_at: {
				field: 'deletedat',
				type : Sequelize.DATE,
			},

			html_bottom: Datatypes.TEXT,
			html_top   : Datatypes.TEXT,

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			keywords          : Datatypes.STRING(512),
			little_description: Datatypes.STRING(512),
			name              : Datatypes.STRING(512),
			sort              : Datatypes.INTEGER,
			text              : Datatypes.TEXT,
			title             : Datatypes.STRING(512),

			updated_at: {
				field: 'updatedat',
				type : Sequelize.DATE,
			},
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'brand',
			timestamps     : true,
			underscored    : true,
		});
};

// CREATE TABLE brand (
// 	id serial PRIMARY KEY,
//  cat integer,
// 	name varchar(512) NOT NULL,
// 	html_bottom text,
// 	html_top text,
// 	keywords varchar(512),
// 	active integer NOT NULL DEFAULT '1',
// 	text text,
// 	title varchar(512),
// 	little_description varchar(512),
// 	sort integer DEFAULT '0',
// 	createdAt timestamp NULL DEFAULT NULL,
// 	deletedAt timestamp NULL DEFAULT NULL,
// 	updatedAt timestamp NULL DEFAULT NULL
// );
