import Index from './Index/index';
import express from 'express'

const
	router = express.Router();

router.route('/cart').get((req, res) => {Index.index(req, res)});
router.route('/send_ordering').post((req, res) => {Index.sendOrdering(req, res)});
export default router
