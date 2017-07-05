import _ from 'lodash';
import adminModule from './admin_module';

export default _.extend({
	admin: {
		module            : adminModule,
		REDIRECT_LOGIN_URL: '',
	},
});
