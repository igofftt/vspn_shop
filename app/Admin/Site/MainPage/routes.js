import express from 'express'
import Page from './Page';

const
	router = express.Router();

router.route('/admin/site/index/main').get(Page.index);
router.route('/admin/site/update/:table').post(Page.indexSave);
export default router
