import _ from 'lodash'

export default (tree, lang) => {
	let
		cj = '',
		echo = '',
		f = '',
		r = '';

	function view_cat(arr, cat = 0, i = 0) {
		if(_.isEmpty(arr[cat]))
			return echo;

		let list = ['', '---', '------', '---------', '------------', '---------------', '------------------'];

		//перебираем в цикле массив и выводим на экран
		for(let ii = 0; Object.keys(arr[cat]).length > ii; ii++)
		{
			let name = arr[cat][ii]['name'];

			try {
				name = JSON.parse(name);
				name = name[lang];
			} catch (err) {
				//console.log(err)
			}

			echo += `<option value="${arr[cat][ii]['id']}">${list[i]}${name}</option>`;

			//рекурсия - проверяем нет ли дочерних категорий
			view_cat(arr,arr[cat][ii]['id'], ii);
		}
	}

	view_cat(tree, 0, 0);
	return echo
};
