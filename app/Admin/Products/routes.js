import express from 'express'
import Mainlist from './Mainlist';
import Details from './Details';

const
	router = express.Router();

router.route('/admin/index/products').get((req, res) => Mainlist(req, res));
router.route('/admin/update/products/:id?/:apply?').get(Details.index).post(Details.update);
export default router
