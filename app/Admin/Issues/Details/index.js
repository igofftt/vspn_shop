import _ from 'lodash';
import models from 'app/Admin/models';
import quickQueries from 'app/Admin/generic/quick-queries';
import settings from 'app/settings';
import {getModule} from 'generic/helpers';
import {_switch} from 'app/Admin/generic/switchFields';

const

	/**
	 * getting issues by id or get all issues
	 * @param req
	 * @param res
	 * @returns {function(): (Promise<any> | Promise.<TResult>)}
	 */
	getIssues = (req, res) => {
		let
			id = parseInt(req.params.id) || 0,
			plugins = settings.admin.plugins,
			table = 'issues';

		const
			render = obj => res.render('admin/Issues/details', {
				id            : id,
				lang          : req.store.getState('lang.lang'),
				plugins       : obj.pluginsThisHtml,
				pluginsLang   : obj.pluginsThisLangHtml,
				pluginsLangStr: JSON.stringify(obj.pluginsThisLangHtml),
				pluginsStr    : JSON.stringify(obj.pluginsThisHtml),
			}),

			generateFields = () => {
				let
					modules = req.store.getState('modules.modules');

				const find = (array, value) => {
					for(let _i = 0; _i < (array || []).length; _i++)
						if(array[_i] === value)
							return _i;

					return -1;
				};

				// find this show module
				let moduleThis = _.find(modules, {id: table})

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

					// end cycle
					if(o.i > o.count)
						return render(_.assign({columnSel, moduleThis, pluginsThisHtml, pluginsThisLangHtml}));

					// create html fields
					let langField = find(moduleThis.lang, o.plugin) === -1 ? 0 : 1;

					// render html for to function render
					return _switch(pluginSingle, nextFor, langField, req, res);
				};

				// Run cycle for find fields
				return forEachPlugins({count: pluginsThis.length, i: 0, plugin: pluginsThis[0]})()
			},

			queue = () => quickQueries.queue(req, res, ['getLang'], generateFields),

			module = () => getModule({req, res, userId: req.user.id}, objModules =>
				req.store.setState('modules.modules', objModules, queue));

		return module();
	},

	/**
	 * get issues json
	 * @param req
	 * @param res
	 */
	getIssuesJson = (req, res) => {
		let
			currentUser = req.body.current_user,
			id = parseInt(req.params.id) || 0,
			whereIssues = req.body.current_user ? {seller_id: currentUser} : {};

		whereIssues = _.merge(whereIssues, {id: id});

		console.log(whereIssues)

		const
			render = () => res.json({
				data    : req.store.getState('issues.issues'),
				statuses: req.store.getState('issues.statuses'),
			}),

			getStatusesIssues = () => {
				let
					arrayId = [],
					issues = req.store.getState('issues.issues');

				for(let i = 0; issues.length > i; i++)
					arrayId.push(issues[i].id);

				return models.statusesModel.findAll({raw: true, where: {parent_id: {$in: arrayId}}})
					.then(dataObl => req.store.setState('issues.statuses', dataObl, render))
			},

			getCurrentIssues = () => models.issuesModel.find({raw: true, where: whereIssues})
				.then(dataObl => req.store.setState('issues.issues', dataObl, getStatusesIssues));

		return getCurrentIssues();
	},

	/**
	 * function update from param Table
	 * @param req
	 * @param res
	 */
	update = (req, res) => {
		return res.json({result: 'ok'});
	};

export default {getIssues, getIssuesJson, update}
