import _ from 'lodash';
import models from 'app/Admin/models';

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

		for(let i = 0; obj.length > i; i++) {
			console.log(obj[i])

			models.tagsModel.create(obj[i]);
		}


		return result(true);
	};

export default {getDataSingle, getTags, newTags};
