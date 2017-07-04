export default (req, res) => {
	res.render('admin/Main/dashboard', {
		error    : req.flash('error').toString(),
		left_menu: req.store.getState('left_menu'),
		ss: console.log(req.store.getState('left_menu')),
		ssw: console.log('ddddd', req.storeObj),
		mata     : {title: 'Админ панель'},
		table    : '',
		user     : req.user,
	});
};
