const
	catalogProduct = (req, res, next) => {
		res.render('site/Catalog/catalogProduct', {
			error        : req.flash('error').toString(),
			mata         : {title: 'VSPN-product'},
			parent_module: 'indexPage',
			this_module  : 'indexPage',
			user         : req.user,
		});
	},

	indexCatalog = (req, res, next) => {
		res.render('site/Catalog/indexCatalog', {
			error        : req.flash('error').toString(),
			mata         : {title: 'VSPN-catalog'},
			parent_module: 'indexPage',
			this_module  : 'indexPage',
			user         : req.user,
		});
	};

export default {catalogProduct, indexCatalog}
