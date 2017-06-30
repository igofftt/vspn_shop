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

	return true;
}
