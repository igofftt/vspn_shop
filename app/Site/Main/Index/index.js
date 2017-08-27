import _ from 'lodash';
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
			genMainArr = arr => {
				let
					newArr = [],
					type_1 = ['block_2', 'block_1_1', 'block_3_1', 'block_1_2', 'block_3_2'],
					type_2 = ['block_1_1', 'block_2', 'block_3_1', 'block_1_2', 'block_3_2'],
					type_3 = ['block_1_1', 'block_3_1', 'block_2', 'block_3_2', 'block_1_2'],
					typeTmp = [];

				_.map(arr, (r, k) => typeTmp.push(k));

				if(_.isEqual(typeTmp, type_1)) {
					newArr.push([{block_2: arr['block_2']}]);
					newArr.push([{block_1_1: arr['block_1_1']}, {block_1_2: arr['block_1_2']}]);
					newArr.push([{block_3_1: arr['block_3_1']}, {block_3_2: arr['block_3_2']}]);
				}

				if(_.isEqual(typeTmp, type_2)) {
					newArr.push([{block_1_1: arr['block_1_1']}, {block_1_2: arr['block_1_2']}]);
					newArr.push([{block_2: arr['block_2']}]);
					newArr.push([{block_3_1: arr['block_3_1']}, {block_3_2: arr['block_3_2']}]);
				}

				if(_.isEqual(typeTmp, type_3)) {
					newArr.push([{block_1_1: arr['block_1_1']}, {block_1_2: arr['block_1_2']}]);
					newArr.push([{block_3_1: arr['block_3_1']}, {block_3_2: arr['block_3_2']}]);
					newArr.push([{block_2: arr['block_2']}]);
				}

				return newArr;
			};

		const
			renderPage = () => res.render('site/Main/indexPage', {
				error    : req.flash('error').toString(),
				main_page: genMainArr(JSON.parse(req.store.getState('site.main_page').text)),

				main_page_key: {
					'block_1_1': 'fig_square color-white',
					'block_2'  : 'fig_square color-white',
					'block_3_1': 'fig_square color-white',
					'block_1_2': 'fig_square color-white',
					'block_3_2': 'fig_square color-white',
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
