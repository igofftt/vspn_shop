import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'lang',

		{
			active: Datatypes.INTEGER,

			created_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},
			deleted_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			little_description: Datatypes.STRING(512),
			name              : Datatypes.STRING(512),
			sort              : Datatypes.INTEGER,
			title             : Datatypes.STRING(512),

			updated_at: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'lang',
			timestamps     : true,
			underscored    : true,
		});
};

// CREATE TABLE lang (
// 	id serial PRIMARY KEY,
// 	name varchar(512) NOT NULL,
// 	active integer NOT NULL DEFAULT '1',
// 	title varchar(512),
// 	little_description varchar(512),
// 	sort integer DEFAULT '0',
// 	createdAt timestamp NULL DEFAULT NULL,
// 	deletedAt timestamp NULL DEFAULT NULL,
// 	updatedAt timestamp NULL DEFAULT NULL
// );
