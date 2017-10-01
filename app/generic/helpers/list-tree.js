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

		if(cat !== 0) r = 'display:'; else r = '';
		if(_.get(arr, `cat.${i}.cat`)) f = arr[cat][i]['cat']; else f = '';
		if(i === 0 ) cj = 'class="files menu_tree tree"'; else cj = '';

		echo += `<ul ${cj}>`;

		//перебираем в цикле массив и выводим на экран
		for(let ii = 0; Object.keys(arr[cat]).length > ii; ii++)
		{
//            $l = '/admin/menu_edit/'.$arr[$cat][$i]['id'].'';
			let l = '#';
			let name = arr[cat][ii]['name'];

			try {
				name = JSON.parse(name);
				name = name[lang];
			} catch (err) {
				//console.log(err)
			}

			echo += `<li class="rowID-${arr[cat][ii]['id']}" id="rowID${arr[cat][ii]['id']}">
            <div class="inp_edit_u inp_edit_${arr[cat][ii]['id']}">
                <input type="radio" name="id_m" autocomplete="off" class="inp_edit flat" 
                title="${name}" value="${arr[cat][ii]['id']}" id="${arr[cat][ii]['id']}"/>
            </div>
            <a href="${l}" >&nbsp;&nbsp;${name}</a>`;

			//рекурсия - проверяем нет ли дочерних категорий
			view_cat(arr,arr[cat][ii]['id'], ii);

			echo += '</li>';
		}

		echo += '</ul>';
	}

	view_cat(tree, 0, 0);
	return echo
};
