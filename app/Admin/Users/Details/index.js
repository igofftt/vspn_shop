import _ from 'lodash';
import models from 'app/Admin/models';
import {hex, getModule} from 'generic/helpers';

const
	index = (req, res, next) => {
		const
			queryUser = modules => models.userModel
				.findById(req.params.id)

				.then(objUser => {
					return models.filesModel
						.findAll({where: {id_album: req.params.id, name_table: 'users'}})
						.then(objFiles => { return {objFiles, objUser}})
				})

				.then(objResult => {res.render('admin/Users/details', {
					data         : objResult.objUser,
					files        : objResult.objFiles,
					left_menu    : req.store.getState('left_menu'),
					id           : req.params.id,
					hex          : hex(Date.now().toString()),
					mata         : {title: `Админ панель - редактирование пользователя - ${_.get(objResult.objUser, 'title')}`},
					modulesPower : modules,
					parent_module: 'users',
					table        : 'users',
					this_module  : 'update',
					timestamp    : Date.now(),
					user         : req.user,
				});

					return null
				})

				.catch(e => next(e));

		getModule({req, res, userId: req.params.id || req.user.id}, queryUser);
	},

	update = (req, res) => {
		let
			idUser = _.get(req, 'params.id', 0),
			password = _.get(req, 'body.pl.password', ''),
			savePass = _.get(req, 'body.pl.save_password', ''),

			userObjUpdate = {
				active  : _.get(req, 'body.pl.active', ''),
				email   : _.get(req, 'body.pl.email', ''),
				name    : _.get(req, 'body.pl.name', ''),
				text    : _.get(req, 'body.pl.text', ''),
				usertype: _.get(req, 'body.pl.usertype', ''),
			};

		userObjUpdate = _.merge(userObjUpdate,
			password !== savePass && password ? {password: hex(password), save_password: savePass || password} : {});

		if(idUser) {
			models.userModel.update(userObjUpdate, {where: {id: idUser}})
				.then(() => updatePowerModel(0))
		} else {
			models.userModel.create(userObjUpdate)
				.then(r => {idUser = r.id; updatePowerModel(0); })
		}

		// добавление обновлени прав пользователя
		const
			endRedir = () => {
				if(_.get(req, 'params.apply'))
					return res.redirect(`/admin/update/users/${idUser}`);
				else
					return res.redirect('/admin/index/users');
			},

			updatePowerModel = i => {
				let
					idMenu = _.toArray(_.get(req, 'body.id_menu'))[i],

					objUpdate = {
						d      : _.get(req, `body.d.${idMenu}_`, 0),
						id_menu: idMenu,
						id_user: idUser,
						r      : _.get(req, `body.r.${idMenu}_`, 0),
						w      : _.get(req, `body.w.${idMenu}_`, 0),
						x      : _.get(req, `body.x.${idMenu}_`, 0),
					};

				models.powerModel.findOne({
					where: {id_menu: idMenu, id_user: idUser},
				})
					.then(power => {
						i++;

						if(!power) {
							models.powerModel.create(objUpdate)
								.then(() => { if(_.get(req, 'body.id_menu').length > i) updatePowerModel(i); else endRedir(); })
						} else {
							models.powerModel.update(objUpdate, {where: {id_menu: idMenu, id_user: idUser}})
								.then(() => { if(_.get(req, 'body.id_menu').length > i) updatePowerModel(i); else endRedir(); })
						}
					});
			};
	};

export default {index, update}
