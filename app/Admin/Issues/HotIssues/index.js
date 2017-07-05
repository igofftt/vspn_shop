export default (req, res) => {
	res.render('admin/Issues/HotIssues/indexHotIssues', {
		error        : req.flash('error').toString(),
		left_menu    : req.store.getState('left_menu'),
		mata         : {title: 'Админ панель'},
		parent_module: 'issues',
		this_module  : 'index',
		user         : req.user,
	});
};
