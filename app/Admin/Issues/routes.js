import express from 'express'
import HotIssues from './HotIssues';

const
	router = express.Router();

router.route('/admin/index/issues').get((req, res) => HotIssues(req, res));
export default router
