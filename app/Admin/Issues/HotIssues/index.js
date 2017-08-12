export default (req, res) => {
	res.render('admin/Issues/index', {
		error        : req.flash('error').toString(),
		left_menu    : req.store.getState('left_menu'),
		meta         : {title: 'Админ панель - Заявки'},
		parent_module: 'issues',
		this_module  : 'index',
		user         : req.user,
	});
};
