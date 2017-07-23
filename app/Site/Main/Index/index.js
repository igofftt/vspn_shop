const
	index = (req, res, next) => {
		res.render('site/Main/indexPage', {
			error        : req.flash('error').toString(),
			mata         : {title: 'VSPN'},
			parent_module: 'indexPage',
			this_module  : 'indexPage',
			user         : req.user,
		});
	};

export default {index}
