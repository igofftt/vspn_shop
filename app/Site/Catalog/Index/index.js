import models from 'app/Admin/models';

const
	catalogProduct = (req, res, next) => {
		const
			renderPage = () => res.render('site/Catalog/catalogProduct', {
				error        : req.flash('error').toString(),
				mata         : {title: 'VSPN'},
				menuTop      : req.store.getState('site.menuTop'),
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMenuTop = callback => models.menuModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.menuTop', dataObl, callback));

		return getMenuTop(renderPage);
	},

	indexCatalog = (req, res, next) => {
		const
			renderPage = () => res.render('site/Catalog/indexCatalog', {
				error        : req.flash('error').toString(),
				mata         : {title: 'VSPN'},
				menuTop      : req.store.getState('site.menuTop'),
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMenuTop = callback => models.menuModel
				.findAll({order: 'id ASC', raw: true})
				.then(dataObl => req.store.setState('site.menuTop', dataObl, callback));

		return getMenuTop(renderPage);
	};

export default {catalogProduct, indexCatalog}
