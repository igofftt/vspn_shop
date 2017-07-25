export default (req, res) => {
	res.render('admin/Main/dashboard', {
		error        : req.flash('error').toString(),
		left_menu    : req.store.getState('left_menu'),
		meta         : {title: 'Админ панель'},
		parent_module: 'dashboard',
		this_module  : 'dashboard',
		user         : req.user,
	});
};
