import _ from 'lodash';
import models from 'app/Admin/models';
import sequelize from 'sequelize';
import {getCat, queryParse} from 'generic/helpers';

const

	/**
	 *
	 * @param req
	 * @param res
	 */
	addToCart = (req, res) => {
		// req.session.cart = {}
		let
			cart = req.session.cart || {},
			id = req.body.id,
			idd = false,
			quantity = req.body.quantity,
			table = 'products',
			type = req.body.type;

		if(type === 'add') {
			for(let i = 0; cart.length > i; i++)
				if(_.get(cart, `${i}.id`, 0) === id) {
					idd = true;
					break;
				}

			if(!idd) {
				_.merge(cart, {[id]: {id: id, quantity: quantity}});
				_.setWith(req.session, 'cart', cart);
			}
		}

		if(type === 'remove') {
			_.unset(cart, _.find(cart, {id: id}).id);
			_.setWith(req.session, 'cart', cart);
		}

		const
			toJson = () => res.json({
				cart    : req.session.cart || {},
				products: req.store.getState('site.products'),
				result  : 'ok',
			}),

			getProducts = () => {
				let
					cartId = _.map(req.session.cart || {}, c => c.id);

				cartId = _.isEmpty(cartId) ? [0] : cartId;

				return models.execute(`
			SELECT "${table}".*, "files"."file", "files"."crop" FROM "${table}" LEFT OUTER JOIN "files" 
			ON "${table}"."id" = "files"."id_album" AND
			"files"."name_table" = '${table}' AND "files"."main" = 1 WHERE "${table}"."id" IN (${cartId}) ORDER BY
			"${table}"."id" ASC;
			`)
					.then(dataObl => req.store.setState('site.products.data', dataObl.rows || [], toJson))};

		return getProducts()
	},



	/**
	 * Functions forming index page a product
	 * @param req
	 * @param res
	 * @param next
	 */
	catalogProduct = (req, res, next) => {
		let
			id = req.params.id;

		const
			mathObj = obj => _.merge(obj, {price_current: obj.price - (obj.price / 100 * obj.discount)}),

			renderPage = () => res.render('site/Catalog/catalogProduct', {
				brand  : req.store.getState('site.brand'),
				error  : req.flash('error').toString(),
				files  : req.store.getState('site.files.product'),
				menu   : req.store.getState('site.menu'),
				menuTop: req.store.getState('site.menuTop'),

				meta: {
					author     : req.store.getState('site.product').author || '',
					description: req.store.getState('site.product').description || '',
					keywords   : req.store.getState('site.product').keywords || '',
					title      : 'VSPN - ' + req.store.getState('site.product').name || '',
				},

				parent_module: 'indexPage',
				product      : mathObj(req.store.getState('site.product')),
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMenuTop = () => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, renderPage)),

			getProduct = () => models.productsModel
				.findById(id, {raw: true, where: {active: 1}})
				.then(dataObl => req.store.setState('site.product', dataObl, getMenuTop)),

			getFiles = () => models.filesModel
				.findAll({limit: 10, raw: true, where: {active: 1, id_album: id, name_table: 'products'}})
				.then(dataObl => req.store.setState('site.files.product', dataObl, getProduct)),

			getBrand = () => models.brandModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.brand', dataObl, getFiles)),

			getMenu = () => models.menuModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.menu', dataObl, getBrand));

		return getMenu();
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
	 */
	indexCatalog = (req, res) => {
		let
			query = queryParse(req);

		let
			paramsNames = {'stone_thickness': 'Толщина камня'};

		const
			renderPage = () => res.render('site/Catalog/indexCatalog', {
				brand        : req.store.getState('site.brand'),
				category     : req.params.id,
				error        : req.flash('error').toString(),
				filters      : req.store.getState('site.filters'),
				menu         : req.store.getState('site.menu'),
				menuTop      : req.store.getState('site.menuTop'),
				meta         : {title: 'VSPN'},
				page         : query.page || 1,

				// TODO move to database
				params_name  :  paramsNames[_.get(req.store.getState('site.filters'), 'params.name')],
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			// Gets min and max val
			getNameParams = () => models.execute(`
			SELECT params ->> 'name' AS name FROM products LIMIT 1`)
				.then(dataObl => req.store.setState('site.filters.params.name', _.get(dataObl.rows, '0.name'), renderPage)),

			// Gets min and max val
			getValMinMax = () => models.execute(`
			SELECT MAX(params ->> 'val') AS val_max, MIN(params ->> 'val') AS val_min FROM products
			`)
				.then(dataObl => req.store.setState('site.filters.params', dataObl.rows, getNameParams)),

			// Gets min and max price
			getPriceMinMax = () => models.execute('SELECT MAX(price) AS price_max, MIN(price) AS price_min FROM products')
				.then(dataObl => req.store.setState('site.filters.price', dataObl.rows, getValMinMax)),

			getMenuTop = () => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, getPriceMinMax)),

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
			show = 12,
			table = 'products',

			where = {
				sort: 'ASC',
				limit: show,
				offset: (currentPage - 1) < 0 ? 0 : (currentPage - 1) * show,
			};

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

			getProducts = () => models.execute(`
			SELECT "${table}".*, "files"."file", "files"."crop" FROM "${table}" LEFT OUTER JOIN "files" 
			ON "${table}"."id" = "files"."id_album" AND
			"files"."name_table" = '${table}' AND "files"."main" = 1 WHERE "${table}"."cat" = ${category} ORDER BY
			 "${table}"."id" ${where.sort} limit ${where.limit} offset ${where.offset};
		`)


			// models.productsModel
			// 	.findAll({limit: show, offset: offset, order: 'id ASC', raw: true, where: {'cat': category}})
				.then(dataObl => req.store.setState('site.products.data', dataObl.rows, subCategories));

		return getProducts();
	};

export default {addToCart, catalogProduct, getCategoryAndSub, indexCatalog, postCatalog}
