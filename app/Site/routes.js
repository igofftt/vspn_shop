import {combineRoute} from 'generic/helpers';
import routesMain from './Main';
import routesCatalog from './Catalog';

export default combineRoute(
	[

		// "routesMain" must be the first
		routesMain.routes,
		routesCatalog.routes,
	]);
