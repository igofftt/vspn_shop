import routesMain from './Main';
import express from 'express'

const
	app = express();

export default () => {
	routesMain.routes();

	// app.get('/messages/', (req, res) => {
	// 	res.render('error/404.html', {message: 'messages', title: 'messages'});
	// });

	// route site. Errors
	// 500
	// app.use((err, req, res, next) => {
	// 	/* istanbul ignore next */
	// 	if(app.get('env') === 'development')
	// 		res.status(500).render(err);
	// 	else
	// 	{
	// 		console.error(err);
	// 		res.status(500).render('admin/error/500');
	// 	}
	//
	// 	next();
	// });

	// 404
	// app.use((req, res) => res.render('admin/error/404', {message: 'Error 404', title: 'Error 404'}));
};
