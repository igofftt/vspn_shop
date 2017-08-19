import QueryTools from './QueryTools/index';
import Components from './Components/index';
import fileManager from './Components/FileManager';
import {combineRoute} from 'generic/helpers';
import express from 'express'

const
	router = express.Router();

router.route('/admin/_tools/getDataSingle').post(QueryTools.getDataSingle);
router.route('/admin/_tools/getTags').post(QueryTools.getTags);
router.route('/admin/components/show_loader_characteristics').post(Components.showLoaderCharacteristics);

export default combineRoute(
	[
		router,
		fileManager.routes,
	]);

