import {combineRoute} from 'generic/helpers';
import routesMain from './Main';
import Issues from './Issues';
import Site from './Site';
import Products from './Products';
import Users from './Users';
import _Tools from './_Tools';

export default combineRoute(
	[

		// "routesMain" must be the first
		routesMain.routes,

		Issues.routes,
		Products.routes,
		Site.routes,
		Users.routes,
		_Tools.routes,
	]);
