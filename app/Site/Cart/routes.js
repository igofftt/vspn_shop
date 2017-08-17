import Index from './Index/index';
import express from 'express'

const
	router = express.Router();

router.route('/cart').get((req, res) => {Index.index(req, res)});
export default router
