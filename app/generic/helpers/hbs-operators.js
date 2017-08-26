import _ from 'lodash';

export default hbs => {
	hbs.registerHelper('iff', (a, operator, b, opts) => {
		let bool = false;

		switch(operator) {
			case'==':
				bool = a == b;
				break;

			case'===':
				bool = a === b;
				break;

			case'>':
				bool = a > b;
				break;

			case'<':
				bool = a < b;
				break;

			case '!=':
				bool = a != b;
				break;

			case '!==':
				bool = a !== b;
				break;

			default:
				throw 'Unknown operator ' + operator;
		}

		return bool ? opts.fn(this) : opts.inverse(this);
	});

	// if value is null print default value
	hbs.registerHelper('df', (value, defaultValue) => value || defaultValue);

	// replace function
	hbs.registerHelper('replace', (text, to, from, of, ) => of === '[]'
		? text.replace(to, `[${from}]`).toLowerCase()
		: text.replace(to, from));

	// toString function
	hbs.registerHelper('tostring', text => _.isObject(text)
		? JSON.stringify(text)
		: _.isString(text) ? text.toString() : '');

	// Register function each mod
	hbs.registerHelper('get', (context, options, getOptions) => {
		if(options)
			options = _.get(context, options);

		return options;
	});

	hbs.registerHelper('forget', (context, getOptions, options) => {
		let ret = '';

		if(getOptions)
			context = _.get(context, getOptions, {});

		context = _.isObject(context) ? _.toArray(context) : context;

		for(let i = 0; i < (context || {}).length; i++)
			ret = ret + options.fn(context[i]);

		return ret;
	});

	return true;
}
