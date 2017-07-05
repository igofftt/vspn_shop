import _ from 'lodash'
import boostrapPaginator from 'generic/boostrapPaginator'
import models from 'app/Admin/models';
import {getModule, queryParse} from 'generic/helpers';

export default (req, res, next) => {
	let query = queryParse(req);
	let limit = 50;
	let page = 1;
	if(req.params.page) page = req.params.page;
	let offset = (page - 1) < 0 ? 0 : (page - 1) * limit;

	let where = {};
	where = query.usertype && _.merge(where, {usertype: query.usertype});

	// выборка нужного количества статей
	const
		findAll = count => models.userModel
			.findAll({limit: limit, offset: offset, order: 'id ASC', where: where})
			.then(objData => getModule({name: 'users', req, res, userId: req.user.id}, module => { return {module, objData}}))

			.then(objResult => {
				res.render('admin/Users/index', {
					count    : count, // общее кол-во статей
					data     : objResult.objData, // статьи
					left_menu: req.store.getState('left_menu'),
					mata     : {title: 'Админ панель - все пользователи'},
					module   : objResult.module[0],

					// номер текущей страницы в пейджинге
					page: page,

					paginate: boostrapPaginator({
						current    : page,
						prelink    : '/admin/index/users',
						rowsPerPage: offset,
						totalResult: count,
					})
						.render(),

					parent_module: 'users',
					table        : 'users',
					this_module  : 'users',
					user         : req.user,
					usertype     : query.usertype,
				});

				return null
			})

			.catch(e => next(e));

	// счетчик статей для педжинга
	models.userModel.count()
		.then(findAll)
		.catch(e => next(e));
};
