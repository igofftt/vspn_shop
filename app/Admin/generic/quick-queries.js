import _ from 'lodash';
import models from 'app/Admin/models';

const
	getLang = (req, res, call) => {
		return models.langModel
			.findAll({raw: true, where: {active: 1}})
			.then(obj => req.store.setState('lang.lang', obj, call))
	},

	/**
	 * start queue
	 * @param req
	 * @param res
	 * @param arr
	 * @param call
	 */
	queue = (req, res, arr, call) => {
		for(let i = 0; arr.length > i; i++)
			if(_.get(module, `exports.default.${arr[i]}`))
				_.get(module, `exports.default.${arr[i]}`)(req, res, ((arr.length - 1) === i ? call : {}));
	}

export default {getLang, queue};
