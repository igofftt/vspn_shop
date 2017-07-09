import _ from 'lodash'
import boostrapPaginator from 'generic/boostrapPaginator'
import models from 'app/Admin/models';
import {getModule, getCat, queryParse} from 'generic/helpers';
import settings from 'app/settings';

const
	getData = (req, res, next) => {
		let query = queryParse(req);

		let
			langQuery = query.lang ? query.lang : 'ru',
			length = _.get(req, 'body.iDisplayLength', 0),
			plugins = settings.plugins,
			response = {},
			skip = _.get(req, 'body.iDisplayStart', 0),
			sort = _.get(req, 'body.sSortDir_0', 0),
			sortF = _.get(req, `body.mDataProp_${_.get(req, 'body.iSortCol_0')}`, 0),
			st = ['Не отображается', 'Отображается'],
			table = req.params.page,
			where = {limit: length, offset: _.isNumber(skip) ? skip : 0, sort: `${sort}`, sortF: `${sortF}`};

		// function for get lang object string
		const getStrLang = str => {
			try {
				let text = JSON.parse(str);
				text = text[langQuery] != 'undefined' ? text[langQuery] : str;
				return !text ? '—' : text;
			} catch(err) {
				return str;
			}
		};

		models.execute(`
			SELECT "${table}".*, "files"."file", "files"."crop" FROM "${table}" LEFT OUTER JOIN "files" 
			ON "${table}"."id" = "files"."id_album" AND
			"files"."name_table" = '${table}' AND "files"."main" = 1  ORDER BY
			 "${table}"."${where.sortF}" ${where.sort} limit ${where.limit} offset ${where.offset};
		`)
			.then(dataObl => models.userModel.count().then(count => {return {count, dataObl: dataObl.rows}}))

			.then(objResult => {
				let allModules = modules => _.assign({count: (objResult.count - 1), dataObl: objResult.dataObl, modules});

				// get module all modules
				return getModule({req, res, userId: req.user.id}, allModules);
			})


			.then(objResult => {
				let
					columnIndex = modules => {
						let columnSel = [];

						for(let i = 0; _.get(modules, '0.column_index', {}).length > i; i++)
							columnSel[i] = _.find(plugins, {sql_column: _.get(modules, '0.column_index', {})[i]});

						return _.assign(objResult, {columnSel})
					};

				// get module for column table
				return getModule({name: table, req, res, userId: req.user.id}, columnIndex);
			})

			.then(objResult => {
				let data = objResult.dataObl;

				for(let i = 0; data.length > i; i++) {
					let
						val = data[i];

					for(let ii = 0; objResult.columnSel.length > ii; ii++) {
						let
							album = '',
							v = objResult.columnSel[ii];

						switch(v.name) {
						case'album':
							if(val.file)
								if(val.crop)
									album = `<img src="/images/files/small/${val.crop}" style="max-width: 200px"/>`;
								else
									album = `<img src="/images/files/small/${val.file}" style="max-width: 200px"/>`;
							else
							if(val.name_free)
								album = `<img src="${val.name_free}" style="max-width: 200px"/>`;
							else
								album = `<img src="/images/files/small/no_img.png" style="max-width: 200px"/>`;

							data[i]['album'] = album;
							break;

						case'name':
							let name;
							name = `<a href="/admin/update/${table}/${val.id}">`;
							name += !val.name.trim() ? 'Без названия' : getStrLang(val.name);
							name += '</a>';
							data[i]['_name'] = data[i]['name'];
							data[i]['name'] = name;
							break;

						case'little_description':
							data[i]['_little_description'] = data[i]['little_description'];
							data[i]['little_description'] = getStrLang(val.little_description).substring(0, 100);
							break;

						case'text':
							data[i]['_text'] = data[i]['text'];
							data[i]['text'] = getStrLang(val.text).substring(0, 100);
							break;

						case'description':
							data[i]['_description'] = data[i]['description'];
							data[i]['description'] = getStrLang(val.description).substring(0, 100);
							break;

						case'active':
							data[i]['_active'] = data[i]['active'];
							data[i]['active'] = st[val['active']];
							break;

						default:
							data[i][v['name']] = !(val[v['name']] || '').trim() ? '—' : val[v['name']];
						}
					}

					let
						id = `<tr class="rowID-${val.id}" ><td class="a-center">
							<input value="${val.id}" id="${val.id}" type="radio" title="${_.escape(val._name)}"
							 class="flat flt-${val.id}" 
							name="table_records" />`;

					if(objResult.modules.link_site_module)
						id += `<a href="${objResult.modules.link_site_module}/${val.id}" title="Посмотреть на сайте"
								target="_blank" >
								<i class="fa fa-mail-forward" ></i >${val.id}</a >`;


					data[i]['id'] = id;
				}

				response['data'] = data;
				response['iTotalRecords'] = objResult.count;
				response['iTotalDisplayRecords'] = objResult.count;
				response['where'] = where;
				response['where_get'] = [];

			//	console.log(response)

				return res.send(JSON.stringify(response));
			})

			.catch(e => next(e));
	},

	/**
	 * function main list
	 * @param req
	 * @param res
	 * @param next
	 * @returns {boolean}
	 */
	index = (req, res, next) => {
		let query = queryParse(req);

		let
			langQuery = query.lang ? query.lang : 'ru',
			limit = 50,
			page = 1,
			plugins = settings.plugins,
			table = req.params.table;

		if(req.params.page) page = req.params.page;
		let offset = (page - 1) < 0 ? 0 : (page - 1) * limit;
		offset =_.isNaN(offset) ? 0 : offset;


		if(!models[`${table}Model`])
			return false;

		// выборка нужного количества статей
		const
			findAll = count => models[`${table}Model`]
				.findAll({limit: limit, offset: offset, order: 'id ASC'})
				.then(dataObl => getCat({lang: langQuery, req, res}, tree => _.assign({dataObl, tree})))

				.then(objResult => {

					// console.log(' objResult.dataObl',  objResult)


					let renderPage = modules => {
						let columnSel = {};

						for(let i = 0; _.get(modules, '0.column_index', {}).length > i; i++)
							columnSel[i] = _.find(plugins, {sql_column: _.get(modules, '0.column_index', {})[i]});

						res.render('admin/Site/Modules/index', {
							column   : columnSel, // колонки для таблицы
							count    : count, // общее кол-во статей
							data     : objResult.dataObl, // статьи
							left_menu: req.store.getState('left_menu'),
							mata     : {title: `Админ панель - ${modules[0].name_module}`},
							modules  : modules[0],

							// номер текущей страницы в пейджинге
							page: page,

							paginate: boostrapPaginator({
								current    : page,
								prelink    : `/admin/index/${table}`,
								rowsPerPage: offset,
								totalResult: count,
							})
								.render(),

							parent_module: 'site',
							table        : table,
							user         : req.user,
							viewsTable   : modules[0].views_module === 'table' ? 1 : 0,
							viewsTree    : modules[0].views_module === 'tree' ? 1 : 0,
							tree         : objResult.tree,
						});

						return null
					};

					// get module for column table
					return getModule({name: table, req, res, userId: req.user.id}, renderPage);
				})

				.catch(e => next(e));

		// счетчик статей для педжинга
		models.userModel.count()
			.then(findAll)
			.catch(e => next(e));
	};

export default {getData, index};
