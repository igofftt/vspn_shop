import _ from 'lodash';
import settings from 'app/settings';
import models from 'app/Admin/models';
import {getArrayVal} from 'generic/helpers';

import express from 'express';

const
	app = express();

export default (options, callback) => {
	let
		keySearch = options.keySearch || 'link_module',
		module = settings.admin.module,
		name = options.name,
		req = options.req,
		user = _.get(options, 'req.user'),
		userId = options.userId;

	const
		resEnd = m => {
			if(_.isFunction(callback))
				return callback(m);
			else
				return m;
		}

	if(_.get(user, 'usertype') === 'admin') {
		module = _.compact(
			_.map(module, (v, k) => {
				if(_.isUndefined(v))
					return;

				if(name === _.get(v, [keySearch]) || !name) {
					v = _.merge(v, {d: 1, r: 1, w: 1, x: 1});
					let m = v.name_module.split('=>');
					v['k'] = m[0].trim();
				} else
					return false;

				if(!v.active)
					return false;

				return v
			})
		);

		// sorting by order
		return resEnd(_.sortBy(module, 'order'));
	} else {
		return userId && models.powerModel.findAll({
			attributes: ['id_user', 'id_menu', 'r', 'x', 'w', 'd'],
			where     : {id_menu: {$in: getArrayVal('id', module)}, id_user: userId},
		})

			.then(rower => {
				module = _.compact(
					_.map(module, v => {
						if(_.isUndefined(v))
							return;

						let pw = _.find(rower, r => r.id_menu === v.id && r);

						if(!_.isEmpty(v.m) && name)
							return _.compact(_.map(v.m, val => _.get(val, [keySearch]) === name && _.merge({
								d: _.get(pw, 'd', 0),
								r: _.get(pw, 'r', 0),
								w: _.get(pw, 'w', 0),
								x: _.get(pw, 'x', 0),
							}, val)))[0];

						if(name === _.get(v, [keySearch]) || !name) {
							v = _.merge({

								// TODO 1 replace on 0
								d: _.get(pw, 'd', 1),
								r: _.get(pw, 'r', 1),
								w: _.get(pw, 'w', 1),
								x: _.get(pw, 'x', 1),
							}, v);

							let m = v.name_module.split('=>');
							v['k'] = m[0].trim();
						} else {
							return false;
						}

						if(!v.active)
							return false;

						return v
					})
				);

				// sorting by order
				return _.sortBy(module, 'order')
			})

			.then(moduleOrder => resEnd(moduleOrder))
			.catch(e => console.log('e', e));
	}
}
