import {getCat} from 'generic/helpers';

const
	index = (req, res, next) => {
		const
			renderPage = () => res.render('site/Cart/indexCart', {
				error        : req.flash('error').toString(),
				meta         : {title: 'VSPN'},
				menuTop      : req.store.getState('site.menuTop'),
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMenuTop = callback => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, callback));

		return getMenuTop(renderPage);
	};

export default {index}
