(function() {
	$.isbl = {
		initialize: function initialize(data) {
			this.conf = new Map((data || {}).pram);
			this.setStyle();
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
