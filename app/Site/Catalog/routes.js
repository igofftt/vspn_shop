import Index from './Index/index';
import express from 'express'

const
	router = express.Router();

router.route('/catalog/:id?').get(Index.indexCatalog).post(Index.postCatalog);
router.route('/catalog/add_to_cart').post(Index.addToCart);
router.route('/product/:id?').get(Index.catalogProduct);
export default router
