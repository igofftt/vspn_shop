import express from 'express'
import Mainlist from './Mainlist';
import Details from './Details';

const
	router = express.Router();

router.route('/admin/index/products').get(Mainlist);
router.route('/admin/load-update/products/:id?/:apply?').post(Details.index);
router.route('/admin/update/products/:id?').post(Details.update);
export default router
