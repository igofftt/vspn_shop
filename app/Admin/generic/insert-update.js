import _ from 'lodash'
import models from 'app/Admin/models';

/**
 * function update from param Table
 * @param req
 * @param res
 */
const
	insertUpdate = (req, res) => {
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
					return res.redirect(`/admin/update/${table}/${id}`);
				else
					return res.redirect(`/admin/index/${table}`);
			};

		// create or update table row
		if(id)
			models[`${table}Model`].update(obj, {where: {id: id}}).then(() => endRedir());
		else
			models[`${table}Model`].create(obj).then(() => endRedir());
	};

export {insertUpdate};
