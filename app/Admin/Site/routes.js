import Modules from './Modules';
import IndexSite from './IndexSite';
import express from 'express';
import {combineRoute} from 'generic/helpers';

const
	router = express.Router();

router.route('/admin/index/site').get(IndexSite);
export default combineRoute([router, Modules.routes]);
