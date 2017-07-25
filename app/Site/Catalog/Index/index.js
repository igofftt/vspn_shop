import models from 'app/Admin/models';
import {getCat, queryParse} from 'generic/helpers';

const
	catalogProduct = (req, res, next) => {
		const
			renderPage = () => res.render('site/Catalog/catalogProduct', {
				error        : req.flash('error').toString(),
				menu         : req.store.getState('site.menu'),
				menuTop      : req.store.getState('site.menuTop'),
				meta         : {title: 'VSPN'},
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMenuTop = () => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, renderPage)),

			getMenu = callback => models.menuModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.menu', dataObl, callback));

		return getMenu(getMenuTop);
	},

	indexCatalog = (req, res, next) => {
		let
			query = queryParse(req);

		const
			renderPage = () => res.render('site/Catalog/indexCatalog', {
				category     : req.params.id,
				error        : req.flash('error').toString(),
				menu         : req.store.getState('site.menu'),
				menuTop      : req.store.getState('site.menuTop'),
				meta         : {title: 'VSPN'},
				page         : query.page || 1,
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMenuTop = () => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, renderPage)),

			getMenu = callback => models.menuModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.menu', dataObl, callback));

		return getMenu(getMenuTop);
	},

	postCatalog = (req, res, next) => {
		let
			query = queryParse(req),
			show = 12;

		const
			toJson = j => res.json({
				current_page: query.page || 1,
				last_page   : parseInt(j.length/show) > 0 ? parseInt(j.length) : 1,
				products    : {data: j},
				result      : 'ok',
				total       : j.length,
			}),

			getProducts = callback => models.productsModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.menu', dataObl, callback));

		return getProducts(toJson);
	};

export default {catalogProduct, indexCatalog, postCatalog}
