import details from './Details/index';
import mainList from './Mainlist/index';
import express from 'express'

const
	router = express.Router();

// mainList
router.route('/admin/site/index/:table?/:page?').get(mainList.index);
router.route('/admin/site/modules/getData/:page?').post(mainList.getData);

// details
router.route('/admin/site/update/:table?/:id?/:apply?').get(details.index).post(details.update);
router.route('/admin/site/modules/getDataSingle').post(details.getDataSingle);
router.route('/admin/site/modules/show_loader').post(details.showLoader);
export default router
