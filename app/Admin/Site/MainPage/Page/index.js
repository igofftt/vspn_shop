import _ from 'lodash';
import models from 'app/Admin/models';
import settings from 'app/settings';
import {getModule} from 'generic/helpers';
import {_switch} from 'app/Admin/generic/switchFields';
import _Tools from 'app/Admin/_Tools/QueryTools';

const

	/**
	 * get main page
	 * @param req
	 * @param res
	 */
	index = (req, res) => {
		let
			table = 'main_page';

		const
			render = () => res.render('admin/MainPage/index', {
				left_menu: req.store.getState('left_menu'),

				main_page: JSON.stringify(_.merge(req.store.getState('site.main_page'),
					{text: JSON.parse(req.store.getState('site.main_page').text)})),

				meta         : {title: 'Админ панель - редактирование - управление главной страницей'},
				parent_module: 'site',
				table        : table,
				this_module  : 'index',
			}),

			getMainPage = () => models.paramsModel.findOne({raw: true, where: {system_name: 'main_page'}})
				.then(dataObl => req.store.setState('site.main_page', dataObl, () => render()));

		return getMainPage();
	},

	indexSave = (req, res) => {
		let
			obj = req.body,
			system_name = obj.system_name,
			table = req.params.table;

		models[`${table}Model`].findOne({raw: true, where: {system_name: system_name}}).then(objResult => {
			// create or update table row
			if((objResult || {}).id)
				models[`${table}Model`].update(_.merge(obj, {text: JSON.stringify(obj.text)}),
					{where: {system_name: system_name}}).then(() => res.redirect('/admin/site/index/main'));
			else
				models[`${table}Model`].create(_.merge(obj, {text: JSON.stringify(obj.text)})).then(() =>
					res.redirect('/admin/site/index/main'));
		});
	};

export default {index, indexSave}
