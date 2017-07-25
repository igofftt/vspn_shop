import models from 'app/Admin/models';
import {getCat} from 'generic/helpers';

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
	},

	indexCatalog = (req, res, next) => {
		const
			renderPage = () => res.render('site/Catalog/indexCatalog', {
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
	};

export default {catalogProduct, indexCatalog}
