import QueryTools from './QueryTools/index';
import Components from './Components/index';
import fileManager from './Components/FileManager';
import {combineRoute} from 'generic/helpers';
import express from 'express'

const
	router = express.Router();

router.route('/admin/_tools/getDataSingle').post(QueryTools.getDataSingle);
router.route('/admin/_tools/getTags').post(QueryTools.getTags);
router.route('/admin/_tools/rowDelete').post(QueryTools.rowDelete);
router.route('/admin/components/show_loader_characteristics').post(Components.showLoaderCharacteristics);
router.route('/admin/components/show_loader_brand').post(Components.showLoaderBrand);
router.route('/admin/_tools/get-characteristics/').post(Components.getCharacteristics);

export default combineRoute(
	[
		router,
		fileManager.routes,
	]);

