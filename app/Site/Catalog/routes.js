import Index from './Index/index';
import express from 'express'

const
	router = express.Router();

router.route('/catalog').get(Index.indexCatalog);
router.route('/product/:id?').get(Index.catalogProduct);
export default router
