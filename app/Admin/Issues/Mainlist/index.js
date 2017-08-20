import models from 'app/Admin/models';
import {queryParse} from 'generic/helpers';

const

	/**
	 * get list issues
	 * @param req
	 * @param res
	 */
	index = (req, res) => {
		let
			query = queryParse(req);

		let
			currentUser = query.user || 0;

		const
			render = () => res.render('admin/Issues/index', {
				current_user : currentUser,
				error        : req.flash('error').toString(),
				issues       : req.store.getState('issues.issues'),
				left_menu    : req.store.getState('left_menu'),
				meta         : {title: 'Админ панель - Заявки'},
				parent_module: 'issues',
				sellers      : req.store.getState('site.sellers'),
				statuses     : req.store.getState('issues.statuses'),
				this_module  : 'index',
				user         : req.user,
			}),

			// users(sellers) for filter by user
			getSellers = () => models.userModel.findAll({raw: true, where: {usertype: 'sellers'}})
				.then(dataObl => req.store.setState('site.sellers', dataObl, render));

		return getSellers();
	};

export default {index};
