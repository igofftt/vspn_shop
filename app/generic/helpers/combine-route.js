import _ from 'lodash'
import express from 'express';

let
	router = express.Router();

export default r => {
	let lTmp = [];
	for(let i = 0; r.length > i; i++ ) {
		let v = r[i];

		if(_.get(v, 'stack.length'))
			for(let ii = 0; v.stack.length > ii; ii++ )
				if(v.stack[ii].route)
					lTmp = _.concat(lTmp, v.stack[ii]);
	}

	let
		routesAll = router;
	routesAll.stack = _.compact(_.map(lTmp, g => g.route && g));

	return routesAll
};
