import QueryTools from './QueryTools/index';
import Components from './Components/index';
import express from 'express'

const
	router = express.Router();

router.route('/admin/_tools/getDataSingle').post(QueryTools.getDataSingle);
router.route('/admin/components/show_loader_characteristics').post(Components.showLoaderCharacteristics);
export default router
