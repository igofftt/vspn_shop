import _ from 'lodash';
import models from 'app/Admin/models';
import settings from 'app/settings';
import {getModule} from 'generic/helpers';
import {_switch} from 'app/Admin/generic/switchFields';

const

	/**
	 * function for query by id and table name
	 * @param req
	 * @param res
	 * @returns {*}
	 */
	getDataSingle = (req, res) => {
		let
			id = parseInt(req.body.id) || 0,
			table = req.body.table;

		models[`${table}Model`]
			.findById(id)
			.then(objData => res.send({data: objData, result: 'ok'}));

		return res
	},

	index = (req, res, next) => {
		let
			id = parseInt(req.params.id) || 0,
			plugins = settings.admin.plugins,
			table = req.params.table;

		const
			queryData = modules => models[`${table}Model`]
				.findById(id)
				.then(dataObj => {
					if(id && !dataObj) {
						res.redirect(`/admin/site/index/${table}/`);
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

				.then(objResult => { res.render('admin/Site/Modules/details', {
					data          : JSON.stringify(objResult.dataObj),
					id            : id,
					lang          : objResult.langObj,
					langShow      : !_.isEmpty(objResult.moduleThis.lang),
					left_menu     : req.store.getState('left_menu'),
					meta          : {title: `Админ панель - редактирование пользователя - ${_.get(objResult, 'userObj.title')}`},
					module        : objResult.moduleThis,
					modulesPower  : modules,
					objData       : objResult.dataObj,
					parent_module : 'site',
					plugins       : objResult.pluginsThisHtml,
					pluginsLang   : objResult.pluginsThisLangHtml,
					pluginsLangStr: JSON.stringify(objResult.pluginsThisLangHtml),
					pluginsStr    : JSON.stringify(objResult.pluginsThisHtml),
					table         : table,
					user          : req.user,
				});

					return null
				})

				.catch(e => next(e));

		getModule({req, res, userId: req.user.id}, queryData);
	},

	/**
	 * function for show plugin in details
	 * @param req
	 * @param res
	 * @returns {*}
	 */
	showLoader = (req, res) => {
		let
			idAlbum = req.body.id_album,
			lang = req.body.lang,
			nameTable = req.body.name_table,
			view = req.body.view;

		return models.filesModel
			.findAll({raw: true, where: {active: 1, id_album: idAlbum, name_table: nameTable}})

			.then(objFiles => res.render(`admin/Site/Modules/plugins/${view}`, {
				files     : objFiles,
				id_album  : idAlbum,
				lang      : lang,
				name_table: nameTable,
				timestamp : Date.now(),
			}));
	},

	/**
	 * function update from param Table
	 * @param req
	 * @param res
	 */
	update = (req, res) => {
		let
			id = _.get(req, 'params.id', 0),
			table = req.params.table;

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
					return res.redirect(`/admin/site/update/${table}/${id}`);
				else
					return res.redirect(`/admin/site/index/${table}`);
			};

		// create or update table row
		if(id)
			models[`${table}Model`].update(obj, {where: {id: id}}).then(() => endRedir());
		else
			models[`${table}Model`].create(obj).then(() => endRedir());
	};

export default {getDataSingle, index, showLoader, update}
