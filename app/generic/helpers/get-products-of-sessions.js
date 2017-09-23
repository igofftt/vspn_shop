import _ from 'lodash';
import models from 'app/Admin/models';

/**
 * Get products of sessions
 * @param req
 * @param res
 * @param callback
 * @private
 */
export default (req, res, callback) => {
	let
		cartId = _.map(req.session.cart || {}, c => c.id),
		table = 'products';

	cartId = _.isEmpty(cartId) ? [0] : cartId;

	return models.execute(`
			SELECT "${table}".*, "files"."file", "files"."crop" FROM "${table}" LEFT OUTER JOIN "files" 
			ON "${table}"."id" = "files"."id_album" AND
			"files"."name_table" = '${table}' AND "files"."main" = 1 WHERE "${table}"."id" IN (${cartId}) ORDER BY
			"${table}"."id" ASC;
			`)

		.then(dataObl => req.store.setState('site.products.data', dataObl.rows || [], _.isFunction(callback)
			? callback(dataObl.rows )
			: () => {},
		))
};
