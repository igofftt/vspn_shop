import Modules from './Modules';
import IndexSite from './IndexSite';
import MainPage from './MainPage';
import express from 'express';
import {combineRoute} from 'generic/helpers';

const
	router = express.Router();

router.route('/admin/index/site').get(IndexSite);

export default combineRoute([
	router,
	MainPage.routes,
	Modules.routes,
]);
