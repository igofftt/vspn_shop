import _ from 'lodash';
import models from 'app/Admin/models';
import {getCat, queryParse} from 'generic/helpers';

const

	/**
	 *
	 * @param req
	 * @param res
	 * @param next
	 */
	addToCart = (req, res, next) => {
		let
			cart = [],
			get_data = req.body.get_data,
			id = req.body.id,
			idd = false,
			quantity = req.body.quantity,
			type = req.body.type;

		if(type === 'add') {
			for(let i = 0; cart.length > i; i++)
				if(cart[i].id === id) {
					idd = true;
					break;
				}

			if(!idd)
				_.merge(cart, {[id]: {id: id, quantity: quantity}})
		}

		if(type === 'remove') {
			for(let i = 0; cart.length > i; i++)
				if(cart[i].id === id) {
					_.unset(cart, i);
					break;
				}

			//$this->requests->session()->put('cart', $cart);
		}

		const
			getProducts = callback => models.productsModel
				.findAll({limit: show, offset: 50, order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.products.data', dataObl, callback)),

			toJson = res.json({
			//	cart    : getsessions(),
				products: req.store.getState('site.products'),
				result  : 'ok',
			})

		return getProducts(toJson)
	},

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
	 * Functions forming object menu
	 * @param req
	 * @param res
	 */
	getCategoryAndSub = (req, res) => {
		let
			category = req.body.category || 0;

		const
			toJson = () => res.json({
				current_category: req.store.getState('site.currentCategory'),
				products        : req.store.getState('site.products'),
				result          : 'ok',
			}),

			getCurrentCategory = () => models.menuModel.findById(category)
				.then(dataObl => req.store.setState('site.currentCategory', dataObl, toJson)),

			getProductsCount = () => models.productsModel.count({where: {'id': category}})
				.then(dataObl => req.store.setState('site.products.cogunt', dataObl, getCurrentCategory));

		return getProductsCount();
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


			getBrand = () => models.brandModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.brand', dataObl, getMenuTop)),

			getMenu = callback => models.menuModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.menu', dataObl, callback));

		return getMenu(getBrand);
	},

	/**
	 * Functions forming json objects procucts
	 * @param req
	 * @param res
	 * @param next
	 */
	postCatalog = (req, res, next) => {
		let
			category = req.body.category || 0,
			currentPage = queryParse(req).page || 1,
			show = 12;

		let
			offset = (currentPage - 1) < 0 ? 0 : (currentPage - 1) * show;

		const
			toJson = j => {
				let count = req.store.getState('site.products.count');

				return res.json({
					current_category: req.store.getState('site.currentCategory'),
					current_page    : currentPage,
					last_page       : count/show > 0 ? (count/show).toFixed(0) : 1,
					products        : req.store.getState('site.products'),
					subCategories   : req.store.getState('site.subCategories'),
					result          : 'ok',
					total           : j.length,
				})
			},

			getProductsCount = () => models.productsModel.count({where: {cat: category}})
				.then(dataObl => req.store.setState('site.products.count', dataObl, toJson)),

			getCurrentCategory = () => models.menuModel.findById(category)
				.then(dataObl => req.store.setState('site.currentCategory', dataObl, getProductsCount)),

			subCategories = () => models.menuModel.findAll({order: 'name ASC', raw: true, where: {'cat': category}})
				.then(dataObl => req.store.setState('site.subCategories', dataObl, getCurrentCategory)),

			getProducts = () => models.productsModel
				.findAll({limit: show, offset: offset, order: 'id ASC', raw: true, where: {'cat': category}})
				.then(dataObl => req.store.setState('site.products.data', dataObl, subCategories));

		return getProducts();
	};

export default {addToCart, catalogProduct, getCategoryAndSub, indexCatalog, postCatalog}
