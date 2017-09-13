import _ from 'lodash';
import models from 'app/Admin/models';
import fs from 'fs';

/**
 * function for query by id and table name
 * @param req
 * @param res
 * @returns {*}
 */
const
	getDataSingle = (req, res) => {
		let
			id = parseInt(req.body.id) || 0,
			table = req.body.table;

		models[`${table}Model`]
			.findById(id)
			.then(objData => res.send({data: objData, result: 'ok'}));

		return res
	},

	getTags = (req, res) => {
		let
			q = (req.body.q).replace(' ', '');

		models.tagsModel
			.findAll({raw: true, where: {name: {$like: `%${q}%`}}})

			.then(objData => res.send({
				incomplete_results: false,

				items: _.isEmpty(objData)
					? [{
						active   : 1,
						createdAt: null,
						deletedAt: null,
						id       : `new_${(new Date()).getTime()}_${q}`,
						id_user  : 1,
						isNew    : true,
						name     : q,
						updatedAt: null,
					}]
					: objData,

				result     : 'ok',
				total_count: objData.length,
			}));

		return res
	},

	/**
	 * function added new tag
	 * @param obj
	 */
	newTags = obj => {
		const
			result = e => e;

		for(let i = 0; obj.length > i; i++)
			models.tagsModel.create(obj[i]);

		return result(true);
	},

	/**
	 * Function delete
	 * @param req
	 * @param res
	 */
	rowDelete = (req, res) => {
		let
			id = req.body.id,
			table = req.body.table;

		const
			remove = () => models[`${table}Model`]
				.destroy({where: {id: id}})
				.then(objData => res.send({data: objData, mess: '', result: 'ok'})),

			getCurrent = () => models[`${table}Model`]
				.findById(id)
				.then(objData => {
					if(objData) {
						if(table === 'files') {
							fs.unlink(`${process.env.PWD}/app/assets/public/images/files/big/${objData.file}`, () => {});
							fs.unlink(`${process.env.PWD}/app/assets/public/images/files/small/${objData.file}`, () => {});
							fs.unlink(`${process.env.PWD}/app/assets/public/images/files/origin/${objData.file}`, () => {});
						}
					}

					return remove()
				});

		return getCurrent()
	};

export default {getDataSingle, getTags, newTags, rowDelete};
