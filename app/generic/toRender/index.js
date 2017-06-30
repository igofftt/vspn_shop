import _ from 'lodash'
import {getModule} from 'generic/helpers'

export default (req, res, next) => {
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

		const
			q1 = () => {
				let scr = 0;
				if(_.isFunction((view || '').split))
					scr = (view || '').split('404').length;

				if(scr === 1) {
					const
						setAppLeftMenu = object => renderBegin(view, {left_menu: object});

					getModule({req: req, res: res, userId: _.get(req, 'user.id')}, setAppLeftMenu);
				} else {
					app.render(view, opts, done)
				}
			};

		// render
		const
			renderBegin = (v, o) => app.render(v, _.merge(opts, o), done);

		if(_.get(req, 'user.id'))
			q1();
		else
			return app.render(view, opts, done)
	};

	next()
};
