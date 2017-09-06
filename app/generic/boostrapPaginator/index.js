import pagination from 'pagination'

/**
 * function helpers. template pagination
 * @param params
 * @returns {pagination.TemplatePaginator}
 */
export default params => {
	// параметры необходимые для прирендера пагинации
	return new pagination.TemplatePaginator({
		current       : params.current,
		prelink       : params.prelink,
		rowsPerPage   : params.rowsPerPage,
		slashSeparator: true,

		template: function(result) {
			let i, len, prelink;
			let html = '<div><ul class="pagination">';

			if (result.pageCount < 2) {
				html += '</ul></div>';
				return html;
			}

			prelink = this.preparePreLink(result.prelink);
			if(result.previous) html += '<li class="page-item"><a href="' + prelink + result.previous + '" class="page-link">Назад</a></li>';

			if(result.range.length) {
				for(i = 0, len = result.range.length; i < len; i++) {
					if(result.range[i] === result.current) {
						html += '<li class="page-item active"><a class="page-link" href="' + prelink + result.range[i] + '">' + result.range[i] + '</a></li>';
					} else {
						html += '<li class="page-item"><a class="page-link" href="' + prelink + result.range[i] + '">' + result.range[i] + '</a></li>';
					}
				}
			}

			if (result.next)
				html += '<li class="page-item"><a href="' + prelink + result.next + '" class="page-link">Вперёд</a></li>';

			html += '</ul></div>';

			return html;
		},

		totalResult: params.totalResult,
	})
};
