import _ from 'lodash';
import adminModule from './admin_module';
import adminPlugins from './admin_plugins';

export default _.extend({
	admin: {
		module            : adminModule,
		plugins           : adminPlugins,
		REDIRECT_LOGIN_URL: '',
	},
});
