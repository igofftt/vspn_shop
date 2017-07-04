import _ from 'lodash'
import {getModule} from 'generic/helpers'

export default (req, res, next) => {
	req.store.setState('left_menu', [{name: 'nam'}])

	res.render = function render(view, options, callback) {
		let
			app = req.app,
			done = callback,
			opts = options || {},
			self = this;

		// merge res.locals
		opts._locals = self.locals;

		// default callback to respond
		done = done || function(err, str) {
				if(err)
					return req.next(err);

				self.send(str);
			};

		return app.render(view, opts, done)
	};

	next()
};
