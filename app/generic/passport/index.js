import _ from 'lodash';
import passport from 'passport';
import passportLocal from 'passport-local';
import models from 'app/Admin/models';
import {hex} from 'generic/helpers';
import express from 'express';

const
	app = express(),
	LocalStrategy = passportLocal.Strategy;

// настройки аутентификации
export default (req, res, next) => {
	passport.use('local', new LocalStrategy(
		{
			passwordField: 'password',
			usernameField: 'email',
		},

		(email, password, done) => {
			models.userModel.findOne({where: {active: 1, email: email, password: hex(password)}})
				.then(user => {
					console.log('ggg', {active: 1, email: email, password: hex(password)})

					if(user)
						return done(null, user);

					return done(null, false, 'Неверный логин или пароль');
				})
				.catch(e => next(e));
		}
	));

	// Serialize sessions
	passport.serializeUser((user, done) => {
		done(null, user.id);
		return null;
	});

	passport.deserializeUser((id, done) => {
		models.userModel.findOne({where: {active: 1, id: id}})
			.then(user => {
				if(user) {
					app.set('user', user);
					done(null, user);
					return null;
				}

				done(null, false, '');
			})
			.catch(err => done(err));
	});

	next();
};
