import _ from 'lodash';
import models from 'app/Admin/models';
import settings from 'app/settings';
import {getModule} from 'generic/helpers';
import {_switch} from 'app/Admin/generic/switchFields';

const
	index = (req, res) => {
		return res.json({result: 'ok'});
	},

	/**
	 * function update from param Table
	 * @param req
	 * @param res
	 */
	update = (req, res) => {
		return res.json({result: 'ok'});
	};

export default {index, update}
