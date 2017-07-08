export default (req, res) => {
	res.render('admin/Site/IndexSite/index', {
		error        : req.flash('error').toString(),
		left_menu    : req.store.getState('left_menu'),
		mata         : {title: 'Админ панель - Управление сайтом'},
		parent_module: 'site',
		this_module  : 'index',
		user         : req.user,
	});
};
