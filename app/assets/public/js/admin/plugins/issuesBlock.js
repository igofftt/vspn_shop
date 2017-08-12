(function() {
	$.isbl = {
		callbackBgDown: function() {
			$('[data-block]').each(function(i, el) {
				$(el).children().each(function(indx, element) {
					$(element).attr({'data-id': indx + 1, style: ''});
				})
			})
		},

		initialize: function initialize(data) {
			this.conf = new Map((data || {}).pram);
			this.setStyle();
			$.isbl.loadOnclick();
		},

		loadOnclick: function() {
			$('[data-block]').sortable({revert: true, update: this.callbackBgDown});

			$('[data-id]')
				.draggable({
					appendTo         : 'body',
					clone            : false,
					connectToSortable: '[data-block]',
					revert           : 'invalid',
					scroll           : false,
				});
		},

		setStyle: function() {
			function init() {
				$('.table-issues-block > .body > .tb').height($(window).height() - 215);
			}

			$(window).resize(function() { init(); });
			init();
		},

		showColumn: function(n, isShow) {
			let selector = $('[data-block="' + n + '"]');

			if(isShow === 'auto') {
				selector.attr('data-hover') == 'true' ? selector.removeAttr('data-hover') : selector.attr('data-hover', true)
			} else
				selector.attr('data-hover', isShow);
		},
	}
})(jQuery);
