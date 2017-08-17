import {combineRoute} from 'generic/helpers';
import routesMain from './Main';
import routesCatalog from './Catalog';
import routesCart from './Cart';

export default combineRoute(
	[

		// "routesMain" must be the first
		routesMain.routes,
		routesCatalog.routes,
		routesCart.routes,
	]);
