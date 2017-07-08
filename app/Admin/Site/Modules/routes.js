import details from './Details/index';
import mainList from './Mainlist/index';
import express from 'express'

const
	router = express.Router();

// mainList
router.route('/admin/index/:table?/:page?').get(mainList.index);
router.route('/admin/modules/getData/:page?').post(mainList.getData);

// details
router.route('/admin/update/:table?/:id?/:apply?').get(details.index).post(details.update);
router.route('/admin/modules/getDataSingle').post(details.getDataSingle);
router.route('/admin/modules/show_loader').post(details.showLoader);
export default router
