import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'tags',

		{
			active: Datatypes.INTEGER,

			createdAt: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			deletedAt: {
				field: 'deleted_at',
				type : Sequelize.DATE,
			},

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			id_user: Datatypes.STRING,
			name   : Datatypes.STRING(512),

			updatedAt: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'tags',
			timestamps     : true,
		});
};

// CREATE TABLE tags (
// 	id serial PRIMARY KEY,
// 	active integer NOT NULL DEFAULT '1',
// 	id_user integer NOT NULL,
// 	name varchar(255) NOT NULL,
// 	created_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL
// );
