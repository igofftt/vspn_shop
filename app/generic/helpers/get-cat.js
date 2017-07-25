import _ from 'lodash';
import settings from 'app/settings';
import models from 'app/Admin/models';
import {listTree, listCategory} from 'app/generic/helpers';

export default (options, callback) => {
	let
		order = options.order || 'sort',
		sort = options.sort || 'ASC',
		table = options.table || 'menu',
		type = options.type || 'tree',
		where = _.merge(settings.where || {}, {order: `${order} ${sort}`, raw: true});

	const
		resEnd = m => {
			if(_.isFunction(callback))
				return callback(m);
			else
				return m;
		};

	return models[`${table}Model`]
		.findAll(where)

		.then(data => {
			if(!data)
				return {};

			let arrCat = {};

			if(!_.isEmpty(data)) {

				//В цикле формируем массив
				for(let i = 0; data.length > i; i++) {
					let row = data[i];

					//Формируем массив, где ключами являются адишники на родительские категории
					if(_.isEmpty(arrCat[row.cat]))
						arrCat[row.cat] = {};

					arrCat[row.cat][Object.keys(arrCat[row.cat]).length] = row;
				}

				if(type === 'array')
					return arrCat

				//возвращаем массив
				if(type === 'category')
					return listCategory(arrCat, options.lang);
				else
					return listTree(arrCat, options.lang);
			} else
				return {};
		})

		.then(result => resEnd(result))
		.catch(e => console.log('e', e));
}
