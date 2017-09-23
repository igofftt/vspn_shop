import Sequelize from 'sequelize';

export default (sequelize, Datatypes) => {
	return sequelize.define(
		'orders',

		{
			count: Datatypes.INTEGER,

			created_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			current_discount: Datatypes.INTEGER,
			current_price   : Datatypes.INTEGER,

			deleted_at: {
				field: 'created_at',
				type : Sequelize.DATE,
			},

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			id_applications: Datatypes.INTEGER,
			id_parent      : Datatypes.INTEGER,
			id_seller      : Datatypes.INTEGER,
			id_user        : Datatypes.INTEGER,
			sum_price      : Datatypes.INTEGER,

			updated_at: {
				field: 'updated_at',
				type : Sequelize.DATE,
			},
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'orders',
			timestamps     : false,
			underscored    : true,
		});
};

// CREATE TABLE orders (
// 	id serial PRIMARY KEY,
// 	count integer NOT NULL,
// 	sum_price integer NOT NULL,
// 	current_price integer NOT NULL,
// 	current_discount integer NOT NULL,
// 	id_parent integer NOT NULL,
// 	id_applications integer NOT NULL,
// 	id_user integer,
// 	id_seller integer,
// 	created_at timestamp NULL DEFAULT NULL,
// 	deleted_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL
// );
