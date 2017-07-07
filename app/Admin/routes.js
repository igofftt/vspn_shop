import {combineRoute} from 'generic/helpers';
import routesMain from './Main';
import fileManager from 'app/generic/FileManager';
import Issues from './Issues';
import Products from './Products';
import Users from './Users';

export default combineRoute(
	[

		// "routesMain" must be the first
		routesMain.routes,
		fileManager.routes,
		Issues.routes,
		Products.routes,
		Users.routes,
	]);
