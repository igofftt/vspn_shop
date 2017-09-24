import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'statuses',

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

			id_user  : Datatypes.INTEGER,
			parent_id: Datatypes.INTEGER,
			status   : Datatypes.INTEGER,

			updated_at: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'statuses',
			timestamps     : false,
			underscored    : true,
		});
};

// CREATE TABLE statuses (
// 	id serial PRIMARY KEY,
// 	id_user integer NOT NULL,
// 	parent_id integer NOT NULL,
// 	active integer NOT NULL DEFAULT '1',
// 	status integer DEFAULT '0',
// 	created_at timestamp NULL DEFAULT NULL,
// 	deleted_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL
// );

