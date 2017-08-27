import {getCat} from 'generic/helpers';

const

	/**
	 * Page Cart
	 * @param req
	 * @param res
	 */
	index = (req, res) => {
		const
			renderPage = () => res.render('site/Cart/indexCart', {
				error        : req.flash('error').toString(),
				menuTop      : req.store.getState('site.menuTop'),
				meta         : {title: 'VSPN'},
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMenuTop = callback => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, callback));

		return getMenuTop(renderPage);
	},

	/**
	 * Page ordering products
	 * @param req
	 * @param res
	 */
	ordering = (req, res) => {
		const
			renderPage = () => res.render('site/Cart/orderingCart', {
				error        : req.flash('error').toString(),
				meta         : {title: 'VSPN'},
				menuTop      : req.store.getState('site.menuTop'),
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMenuTop = callback => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, callback));

		return getMenuTop(renderPage);
	},

	/**
	 * send & save ordering
	 * @param req
	 * @param res
	 */
	sendOrdering = (req, res) => {
		const
			toJson = () => res.json({
				result: 'ok',
			});

		return toJson();
	};

export default {index, ordering, sendOrdering}
