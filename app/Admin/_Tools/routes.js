import QueryTools from './QueryTools/index';
import express from 'express'

const
	router = express.Router();

router.route('/admin/_tools/getDataSingle').post(QueryTools.getDataSingle);
export default router
