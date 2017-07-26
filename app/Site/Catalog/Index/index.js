import models from 'app/Admin/models';
import {getCat, queryParse} from 'generic/helpers';

const

	/**
	 * Functions forming index page a product
	 * @param req
	 * @param res
	 * @param next
	 */
	catalogProduct = (req, res, next) => {
		const
			renderPage = () => res.render('site/Catalog/catalogProduct', {
				brand        : req.store.getState('site.brand'),
				error        : req.flash('error').toString(),
				menu         : req.store.getState('site.menu'),
				menuTop      : req.store.getState('site.menuTop'),
				meta         : {title: 'VSPN'},
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getBrand = () => models.brandModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.brand', dataObl, renderPage)),

			getMenuTop = () => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, getBrand)),

			getMenu = callback => models.menuModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.menu', dataObl, callback));

		return getMenu(getMenuTop);
	},

	/**
	 * Functions forming index page a catalog
	 * @param req
	 * @param res
	 * @param next
	 */
	indexCatalog = (req, res, next) => {
		let
			query = queryParse(req);

		const
			renderPage = () => res.render('site/Catalog/indexCatalog', {
				brand        : req.store.getState('site.brand'),
				brandf        : console.log(req.store.getState('site.brand')),
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

			getBrand = () => models.brandModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.brand', dataObl, renderPage)),

			getMenuTop = () => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, getBrand)),

			getMenu = callback => models.menuModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.menu', dataObl, callback));

		return getMenu(getMenuTop);
	},

	/**
	 * Functions forming json objects procucts
	 * @param req
	 * @param res
	 * @param next
	 */
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
