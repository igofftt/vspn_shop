import express from 'express'
import HotIssues from './HotIssues';
import Details from './Details';

const
	router = express.Router();

router.route('/admin/index/issues').get(HotIssues);
router.route('/admin/load-update/issues/:id?').post(Details.index);
router.route('/admin/update/issues/:id?').post(Details.update);
export default router
