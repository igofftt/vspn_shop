export default (sequelize, Datatypes) => {
	return sequelize.define(
		'users',

		{
			active    : Datatypes.INTEGER,
			created_at: Datatypes.DATE,
			email     : Datatypes.STRING(50),

			id: {
				autoIncrement: true,
				primaryKey   : true,
				type         : Datatypes.INTEGER,
			},

			name          : Datatypes.STRING(50),
			password      : Datatypes.STRING(50),
			remember_token: Datatypes.STRING(100),
			save_password : Datatypes.STRING(32),
			text          : Datatypes.TEXT,
			updated_at    : Datatypes.DATE,
			username      : Datatypes.STRING(30),
			usertype      : Datatypes.STRING(30),
		},

		{
			freezeTableName: true,
			paranoid       : true,
			tableName      : 'users',
			timestamps     : false,
		});
};

// CREATE TABLE users (
// 	id serial PRIMARY KEY,
// 	name varchar(255) NOT NULL,
// 	email varchar(255) NOT NULL,
// 	password varchar(255)  NOT NULL,
// 	remember_token varchar(100) DEFAULT NULL,
// 	created_at timestamp NULL DEFAULT NULL,
// 	updated_at timestamp NULL DEFAULT NULL,
// 	alias text NOT NULL,
// 	usertype text NOT NULL,
// 	moreaddress text NOT NULL,
// 	text text NOT NULL,
// 	active integer NOT NULL DEFAULT '1',
// 	save_password varchar(32) NOT NULL,
// 	power integer NOT NULL
// );
