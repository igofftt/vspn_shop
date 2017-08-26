import {getCat} from 'generic/helpers';
import models from 'app/Admin/models';

const

	/**
	 * Main page
	 * @param req
	 * @param res
	 */
	index = (req, res) => {
		const
			renderPage = () => res.render('site/Main/indexPage', {
				error    : req.flash('error').toString(),
				main_page: JSON.parse(req.store.getState('site.main_page').text),

				main_page_key: {
					'block_1_1': 'fig_square fig_small color-white',
					'block_2'  : 'fig_square fig_big color-white',
					'block_3_1': 'fig_square fig_small color-white',
					'block_1_2': 'fig_square fig_small color-white',
					'block_3_2': 'fig_square fig_small color-white',
				},

				menuTop      : req.store.getState('site.menuTop'),
				meta         : {title: 'VSPN'},
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMainPage = () => models.paramsModel.findOne({raw: true, where: {system_name: 'main_page'}})
				.then(dataObl => req.store.setState('site.main_page', dataObl, () => renderPage())),

			getMenuTop = () => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, getMainPage));

		return getMenuTop(renderPage);
	};

export default {index}
