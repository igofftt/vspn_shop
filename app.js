import bodyParser from 'body-parser';
import cookieParser from 'cookie-parser';
import path from 'path';
import express from 'express';
import indexApp from 'app/index';
import dotenv from 'dotenv' ;
import cookieSession from 'cookie-session';
import flash from 'connect-flash';
import passport from 'passport';
import passportStrategy from 'generic/passport';
import {hbsOperators} from 'generic/helpers';
import hbs from 'express-hbs';
import fileUpload from 'express-fileupload';

const
	app = express(),
	env = dotenv.config();

app.use(cookieSession(
	{
		cookie           : {maxAge: 60000},
		resave           : false,
		saveUninitialized: false,
		secret           : 'woot',
	}
));

// подключение livereload
if(app.get('env') === 'development') app.use(require('connect-livereload')());

// app.use(storeGenerator());
app.use(flash());
app.use(passportStrategy);
app.use(express.static('app/assets')); // static files
app.use(bodyParser.json()); // for parsing application/json
app.use(bodyParser.urlencoded({extended: true})); // for parsing application/x-www-form-urlencoded
app.use(cookieParser());

// initialize session
app.use(passport.initialize());
app.use(passport.session());

// file upload
app.use(fileUpload());

// use hbs for all ejs templates:
app.set('view engine', 'hbs');

// configure the view engine
app.engine('hbs', hbs.express4({partialsDir: __dirname + '/app/views/'}));

// configure views path
app.set('views', path.join(__dirname,'/app/views'));

// app init
// app.use('/admin/*', indexApp.index);
// app.use(indexApp.routes);
// app.use('/admin/*', indexApp.error404);
// app.use('/admin/*', indexApp.error500);

// register operators hbs
hbsOperators(hbs);
app.listen(8030);

export default app;
