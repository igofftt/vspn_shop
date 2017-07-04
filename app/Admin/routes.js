import {combineRoute} from 'generic/helpers';
import routesMain from './Main';
import fileManager from 'app/generic/FileManager';

// TODO: "routesMain" must be the first
export default combineRoute([routesMain.routes, fileManager.routes]);
