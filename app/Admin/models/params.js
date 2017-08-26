import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'params',

		{
			active: Datatypes.INTEGER,

			createdAt: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			deletedAt: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			html_bottom: Datatypes.TEXT,
			html_top   : Datatypes.TEXT,

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			name       : Datatypes.STRING(512),
			system_name: Datatypes.STRING(512),
			text       : Datatypes.TEXT,

			updatedAt: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'params',
			timestamps     : false,
		});
};

// CREATE TABLE params (
// 	id serial PRIMARY KEY,
// 	active integer NOT NULL DEFAULT '1',
// 	html_bottom text,
// 	html_top text,
// 	text text,
// 	created_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL
// );
