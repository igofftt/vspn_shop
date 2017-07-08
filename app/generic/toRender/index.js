import _ from 'lodash'
import {getModule} from 'generic/helpers'

export default (req, res, next) => {
	const
		setSt = (name, obj) => {
			req.store.setState(name, obj);
			next();

			return null;
		};

	const
		renderFn = m => setSt('left_menu', m),

		q1 = () => {
			let scr = 0;

			if(_.isFunction((req.uri || '').split))
				scr = (req.uri || '').split('404').length;

			if(scr === 1)
				getModule({req: req, res: res, userId: _.get(req, 'user.id')}, renderFn);
			else
				next()
		};

	if(!_.get(req, 'user.id'))
		next();
	else
		q1();
};
