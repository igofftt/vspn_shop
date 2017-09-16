import _ from 'lodash';
import {getCat, queryParse} from 'generic/helpers';
import models from 'app/Admin/models';

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
			classAttr = inp.classAttr ? inp.classAttr : '',
			langArr = l ? '--options--' : '',
			langQuery = query.lang ? query.lang : 'ru';

		const resultR = obj => {
			let html = `<div class="form-group">
			<label class="control-label">${inp.nameText}</label> 
			<div class="">
			<select ${inp.body.multiple || ''} name="${inp.nameAttr}${langArr}" id="${inp.idAttr}" class="form-control 
			${classAttr}">
			${obj.sel}
			</select>
			</div>
			<br class="clear"/>
			</div>`;

			return coll(html, inp.name);
		};

		if(inp['body']['type'] === 'replace')
			return getCat({lang: langQuery, req, res, type: 'category'}, tree => resultR({
				sel: inp['body']['text'].replace('{-option-}', tree),
			}));
		else
			return resultR({sel: inp['body']['text']});
	},

	_catList = (inp, coll, l, req, res) => {
		let
			classAttr = inp.classAttr ? inp.classAttr : '',
			langArr = l ? '--options--' : '';

		const
			resultR = obj => {
				let opt = '';

				for(let i = 0; obj.length > i; i++)
					opt += `<option value="${obj[i].id}">${obj[i].name}</option>`;

				let html = `<div class="form-group">
					<label class="control-label">${inp.nameText}</label> 
					<div class="">
					<select ${inp.body.multiple || ''} name="${inp.nameAttr}${langArr}" id="${inp.idAttr}" class="form-control 
					${classAttr}">
					${inp['body']['text'].replace('{-option-}', opt)}
					</select>
					</div>
					<br class="clear"/>
					</div>`;

				return coll(html, inp.name);
			},

			getList = () => models[`${inp['body']['table']}Model`]
				.findAll({raw: true, where: {active: 1}})
				.then(objRes => resultR(objRes));

		return getList();
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
			<label class="">${inp.nameText}</label>
			<div class="">
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
			<label class="">${inp.nameText}</label>
			<div class="">
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
		if(c.typeField === 'input')
			return _input(c, n, l);

		if(c.typeField === 'textarea')
			return _textarea(c, n, l);

		if(c.typeField === 'select')
			return _cat(c, n, l, req, res);

		if(c.typeField === 'select-list')
			return _catList(c, n, l, req, res);

		let html;

		if(_.get(c, 'body.text'))
			if(c.typeField === 'full-album')
				html = _.get(c, 'body.text');
			else
				html = `<div class="form-group">
				<label class="">${c.nameText}</label>
				<div class="">${_.get(c, 'body.text')}</div>
				<br class="clear">
				</div>`;
		else
			html = `<div class="form-group">
			<label class="">${c.nameText}</label>
			<div class=""><div id="${c.name}"></div></div>
			<br class="clear">
			</div>`;

		return n(html, c.name)
	};

export {_switch};
