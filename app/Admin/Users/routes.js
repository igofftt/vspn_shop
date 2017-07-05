import details from './Details/index';
import mainList from './Mainlist/index';
import express from 'express'

const
	router = express.Router();

router.route('/admin/index/users/:page?').get(mainList);
router.route('/admin/update/users/:id?/:apply?').get(details.index).post(details.update);
router.route('/admin/update/users/').get(details.index);
export default router
