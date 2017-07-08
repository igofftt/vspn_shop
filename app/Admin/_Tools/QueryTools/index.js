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
	};

export default {getDataSingle};
