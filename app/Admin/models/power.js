export default (sequelize, Datatypes) => {
	return sequelize.define(
		'power',

		{
			createdAt: Datatypes.DATE,
			d        : Datatypes.STRING(1),
			deletedAt: Datatypes.STRING(1),

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			id_menu  : Datatypes.STRING,
			id_user  : Datatypes.STRING,
			r        : Datatypes.STRING(1),
			updatedAt: Datatypes.DATE,
			w        : Datatypes.STRING(1),
			x        : Datatypes.STRING(1),
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'power',
			timestamps     : true,
		});
};

// CREATE TABLE power (
// 	id serial PRIMARY KEY,
// 	id_user integer NOT NULL,
// 	id_menu varchar(32) NOT NULL,
// 	r integer NOT NULL,
// 	x integer NOT NULL,
// 	w integer NOT NULL,
// 	d integer NOT NULL,
// 	created_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL
// );
