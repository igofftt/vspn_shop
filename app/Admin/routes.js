import {combineRoute} from 'generic/helpers';
import routesMain from './Main';
import fileManager from 'app/generic/FileManager';
import Issues from './Issues';
import Users from './Users';

export default combineRoute(
	[

		// "routesMain" must be the first
		routesMain.routes,
		fileManager.routes,
		Issues.routes,
		Users.routes,
	]);
