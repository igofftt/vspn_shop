export default (req, res) => {
	res.render('admin/Products/index', {
		error        : req.flash('error').toString(),
		left_menu    : req.store.getState('left_menu'),
		mata         : {title: 'Админ панель - весь товар'},
		parent_module: 'products',
		this_module  : 'index',
		user         : req.user,
	});
};
