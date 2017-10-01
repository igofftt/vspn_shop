import express from 'express'
import Mainlist from './Mainlist';
import Details from './Details';
import ProductsDetails from '../Products/Details';

const
	router = express.Router();

router.route('/admin/index/issues').get(Mainlist.index);
router.route('/admin/load-update/issues/:id?').post(Details.getIssues);
router.route('/admin/load-update/issues_json/:id?').post(Details.getIssuesJson);
router.route('/admin/load-update/products_json/:id?').post(ProductsDetails.getProductByIdAppJson);
router.route('/admin/update/issues/:id?').post(Details.update);
router.route('/admin/load-issues/issues').post(Details.loadIssues);
export default router
