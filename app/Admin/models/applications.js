import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'applications',

		{
			active   : Datatypes.INTEGER,
			apartment: Datatypes.STRING(512),
			cite     : Datatypes.STRING(512),

			created_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			deleted_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			email: Datatypes.STRING(512),
			house: Datatypes.STRING(512),

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			little_description: Datatypes.STRING(512),
			name              : Datatypes.STRING(512),
			phone             : Datatypes.STRING(512),
			sort              : Datatypes.INTEGER,
			street            : Datatypes.STRING(512),
			surname           : Datatypes.STRING(512),

			updated_at: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'applications',
			timestamps     : true,
			underscored    : true,
		});
};

// CREATE TABLE applications (
// 	id serial PRIMARY KEY,
// 	name varchar(512) NOT NULL,
// 	apartment varchar(512) NOT NULL,
// 	cite varchar(512) NOT NULL,
// 	email varchar(512),
// 	phone varchar(512) NOT NULL,
// 	active integer NOT NULL DEFAULT '1',
// 	little_description varchar(512),
// 	sort integer DEFAULT '0',
// 	street varchar(512) NOT NULL,
// 	surname varchar(512) NOT NULL,
// 	created_at timestamp NULL DEFAULT NULL,
// 	deleted_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL
// );
