import {getCat, queryParse} from 'generic/helpers';

const

	/**
	 * функция рендера cat
	 * @param inp
	 * @param coll
	 * @param l - lang field
	 * @param req
	 * @param res
	 * @returns {*}
	 * @private
	 */
	_cat = (inp, coll, l, req, res) => {
		let query = queryParse(req);

		let
			langArr = l ? '--options--' : '',
			langQuery = query.lang ? query.lang : 'ru';

		const resultR = obj => {
			let html = `<div class="form-group">
			<label class="col control-label col-md-3 col-sm-3 col-xs-12">${inp.nameText}</label> 
			<div class="col col-md-6 col-sm-6 col-xs-12">
			<select name="${inp.nameAttr}${langArr}" id="${inp.idAttr}" class="form-control select2">
			${obj.sel}
			</select>
			</div>
			<br class="clear"/>
			</div>`;

			return coll(html, inp.name);
		};

		if(inp['body']['type'] = 'insert')
			return getCat({lang: langQuery, req, res, type: 'category'}, wood => resultR({
				sel: inp['body']['text'].replace('{-option-}', wood),
			}));
		else
			return resultR({sel: inp['body']['text']});
	},

	/**
	 * функция рендера input
	 * @param inp
	 * @param coll
	 * @param l - lang field
	 * @return string
	 */
	_input = (inp, coll, l) => {
		let
			classAttr = inp.classAttr ? inp.classAttr : '',
			langArr = l ? '--options--' : '';

		let html = `<div class="form-group">
			<label class="col control-label col-md-3 col-sm-3 col-xs-12">${inp.nameText}</label>
			<div class="col col-md-6 col-sm-6 col-xs-12">
			<input type="text" name="${inp.nameAttr}${langArr}" id="${inp.idAttr}" class="form-control ${classAttr}" placeholder="${inp.nameText}">
			</div>
			<br class="clear"/>
			</div>`;

		return coll(html, inp.name);
	},

	/**
	 * функция рендера textarea
	 * @param inp
	 * @param coll
	 * @param l - lang field
	 * @return string
	 */
	_textarea = (inp, coll, l) => {
		let
			classAttr = inp.classAttr ? inp.classAttr : '',
			langArr = l ? '--options--' : '';

		let html = `<div class="form-group">
			<label class="col control-label col-md-3 col-sm-3 col-xs-12">${inp.nameText}</label>
			<div class="col col-md-6 col-sm-6 col-xs-12">
			<textarea class="form-control ${classAttr}" id="${inp.idAttr}" name="${inp.nameAttr}${langArr}" placeholder="${inp.nameText}" rows="3"></textarea>
			</div>
			<br class="clear"/>
			</div>`;

		return coll(html, inp.name);
	},

	/**
	 *
	 * @param c - object plugin
	 * @param n - callback
	 * @param l - lang field
	 * @param req
	 * @param res
	 * @returns {string}
	 * @private
	 */
	_switch = (c, n, l, req, res) => {

// console.log('ccc', c, n, l)

		if(c.typeField === 'input')
			return _input(c, n, l);

		if(c.typeField === 'textarea')
			return _textarea(c, n, l);

		if(c.typeField === 'select')
			return _cat(c, n, l, req, res);

		let html;

		if(_.get(c, 'body.text'))
			if(c.typeField === 'full-album')
				html = _.get(c, 'body.text');
			else
				html = `<div class="form-group">
				<label class="col control-label col-md-3 col-sm-3 col-xs-12">${c.nameText}</label>
				<div class="col col-md-6 col-sm-6 col-xs-12">${_.get(c, 'body.text')}</div>
				<br class="clear">
				</div>`;
		else
			html = `<div class="form-group">
			<label class="col control-label col-md-3 col-sm-3 col-xs-12">${c.nameText}</label>
			<div class="col col-md-6 col-sm-6 col-xs-12"><div id="${c.name}"></div></div>
			<br class="clear">
			</div>`;

		return n(html, c.name)
	};

export {_switch};
