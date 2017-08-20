import express from 'express'
import Mainlist from './Mainlist';
import Details from './Details';

const
	router = express.Router();

router.route('/admin/index/issues').get(Mainlist.index);
router.route('/admin/load-update/issues/:id?').post(Details.getIssues);
router.route('/admin/load-update/issues_json/:id?').post(Details.getIssuesJson);
router.route('/admin/update/issues/:id?').post(Details.update);
export default router
