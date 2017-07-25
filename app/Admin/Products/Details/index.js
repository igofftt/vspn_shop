import _ from 'lodash';
import models from 'app/Admin/models';
import settings from 'app/settings';
import {getModule} from 'generic/helpers';
import {_switch} from 'app/Admin/generic/switchFields';

const
	index = (req, res, next) => {
		let
			id = parseInt(req.params.id) || 0,
			plugins = settings.admin.plugins,
			table = 'products';

		const
			queryData = modules => models[`${table}Model`]
				.findById(id)
				.then(dataObj => {
					if(id && !dataObj) {
						res.redirect(`/admin/index/${table}/`);
						return next();
					}

					return models.langModel
						.findAll({raw: true, where: {active: 1}})
						.then(langObj => {return {dataObj, langObj}});
				})

				.then(objResult => {
					const find = (array, value) => {
						for(let _i = 0; _i < (array || []).length; _i++)
							if(array[_i] === value)
								return _i;

						return -1;
					};

					// find this show module
					let moduleThis = _.find(modules, {link_module: table});

					// find in m category
					if(!moduleThis)
						moduleThis = _.find((_.find(modules, {m: [{link_module: table}]}) || {}).m, {link_module: table});

					// each column table create fields html
					let
						columnSel = [],
						pluginsThis = moduleThis.plugins || {},
						pluginsThisHtml = {},
						pluginsThisLangHtml = {};

					// foreach fields and create html object
					// r - return html
					// n - return name plugin
					const forEachPlugins = o => (r, n) => {
						o.i++;

						let
							nextFor = forEachPlugins({count: o.count, i: o.i, plugin: pluginsThis[o.i]}),
							pluginSingle = _.find(plugins, {name: o.plugin}),

							// search plugin return name from swich
							pluginSingleSwitch = _.find(plugins, {name: n});

						if(find(moduleThis.lang, n) === -1)
							pluginsThisHtml[n] = {
								html   : r,
								plugins: pluginSingleSwitch,
							};
						else
							pluginsThisLangHtml[n] = {
								html   : r,
								plugins: pluginSingleSwitch,
							};

						if(o.i > o.count)
							return _.assign(objResult, {columnSel, moduleThis, pluginsThisHtml, pluginsThisLangHtml});

						// create html fields
						let lanfField = find(moduleThis.lang, o.plugin) === -1 ? 0 : 1;
						return _switch(pluginSingle, nextFor, lanfField, req, res);
					};

					if(pluginsThis.length)
						return forEachPlugins({count: pluginsThis.length, i: 0, plugin: pluginsThis[0]})();
					else
						return _.assign(objResult, {columnSel, moduleThis, pluginsThisHtml, pluginsThisLangHtml})
				})

				.then(objResult => res.render('admin/Products/details', {
					data          : JSON.stringify(objResult.dataObj),
					id            : id,
					lang          : objResult.langObj,
					langShow      : !_.isEmpty(objResult.moduleThis.lang),
					// left_menu     : req.store.getState('left_menu'),
					meta          : {title: `Админ панель - редактирование - ${_.get(objResult, 'dataObj.title')}`},
					module        : objResult.moduleThis,
					modulesPower  : modules,
					objData       : objResult.dataObj,
					parent_module : table,
					plugins       : objResult.pluginsThisHtml,
					pluginsLang   : objResult.pluginsThisLangHtml,
					pluginsLangStr: JSON.stringify(objResult.pluginsThisLangHtml),
					pluginsStr    : JSON.stringify(objResult.pluginsThisHtml),
					table         : table,
					this_module   : 'update',
					// user          : req.user,
				}))

				.catch(e => next(e));

		getModule({req, res, userId: req.user.id}, queryData);
	},

	/**
	 * function update from param Table
	 * @param req
	 * @param res
	 */
	update = (req, res) => {
		let
			id = _.get(req, 'params.id', 0),
			table = 'products';

		// get object form data
		let obj = {}, pl = _.get(req, 'body.pl', {});

		// serialization object
		for(let i = 0; Object.keys(pl).length > i; i++)
			obj[Object.keys(pl)[i]] = _.isObject(pl[Object.keys(pl)[i]])
				? _.unescape(JSON.stringify(pl[Object.keys(pl)[i]]))
				: pl[Object.keys(pl)[i]];

		const
			endRedir = () => {
				if(_.get(req, 'params.apply'))
					return res.redirect(`/admin/update/${table}/${id}`);
				else
					return res.redirect(`/admin/index/${table}`);
			};


		console.log('	models[`${table}Model`]', id)

		// create or update table row
		if(id && id > 0)
			models[`${table}Model`].update(obj, {where: {id: id}}).then(() => endRedir());
		else
			models[`${table}Model`].create(obj).then(() => endRedir());
	};

export default {index, update}
