import passport from 'passport';
import dashboard from './Dashboard/index';
import express from 'express'

const
	router = express.Router();

// middleware для проверки на авторизацию
router.route(['/admin/*', '/admin'])
	.get((req, res, next) => {
		if(req.originalUrl === '/admin' || req.originalUrl === '/admin/')
			return res.redirect('/admin/login');

		if(req.isAuthenticated() || req.originalUrl === '/admin/login')
			return next();

		res.redirect('/admin/login');
	});

router.route(['/admin/login']) // рендер страницы авторизации
	.get((req, res) => {
		if(req.isAuthenticated())
			return res.redirect('/admin/dashboard');

		res.render('admin/login', {
			error: req.flash('error').toString(),
			meta : {title: 'Админ панель'},
		});
	})

	// выбор способа авторизации/ редиректы успешной и неудачной авторизации
	.post(passport.authenticate('local', {
		failureFlash   : true,
		failureRedirect: '/admin/login',
		successRedirect: '/admin',
	}));

// logout
router.route('/admin/logout').get((req, res) => { req.logout(); res.redirect('/admin/login'); });
router.route('/admin/dashboard').get((req, res) => {dashboard(req, res)});
export default router
