(function() {
	$.isbl = {
		callbackBgDown: function() {
			$.isbl.rebaseBg()
		},

		initialize: function initialize(data) {
			this.conf = new Map((data || {}).pram);
			this.loadIssues();
			$.isbl.loadOnclick();
		},

		/**
		 * Load Issue details
		 */
		loadIssue: function() {
			let
				id = $(this).data('id'),
				table = $(this).data('table') || 'issues';

			$.ajax({
				cache   : false,
				data    : {id: id, table: table},
				dataType: 'html',

				success: function(data) {
					setTimeout(function() { $.adm.editM('show'); }, 0);

					$('#container-editor .body').html('<div onclick="$.adm.editM(\'hide\')" class="close">' +
						'<i class="fa fa-close"></i>' +
						'</div>' + data);
				},

				type: 'post',
				url : '/admin/load-update/' + table + '/' + id,
			});
		},

		/**
		 * Load Issue list views
		 */
		loadIssues: function() {
			let
				table = 'issues';

			$.ajax({
				cache   : false,
				data    : {table: table},
				dataType: 'json',

				success: function(data) {
					if(data.result === 'ok')
						_.map(data.data, function(v) {
							$('[data-block="' + v.status + '"]').append(
								'<div class="bg" data-id="' + v.id + '"><div>' +
								v.surname +
								v.name_person +
								'<p>' + v.cite + ', ' + v.street + '</p>' +
								'<p>' + v.phone + '</p>' +
								'<p>' + v.created_at + '</p>' +
								'<p>Сумма заказа: -</p>' +
								'</div></div>',
							)
						});

					$.isbl.setStyle();
					$.isbl.rebaseBg();
					$('[data-block]').sortable({revert: true, update: $.isbl.callbackBgDown});

					$('[data-id]')
						.draggable({
							appendTo         : 'body',
							clone            : false,
							connectToSortable: '[data-block]',
							revert           : 'invalid',
							scroll           : false,
						});

					$('[data-id]').click($.isbl.loadIssue);
				},

				type: 'post',
				url : '/admin/load-issues/' + table + '/',
			});
		},

		loadOnclick: function() {
			$('[data-show-slide-menu]').click(function() {
				if(document.getElementsByClassName('top-slide-menu')[0].hasAttribute('data-hidden'))
					$('.top-slide-menu').removeAttr('data-hidden');
				else
					$('.top-slide-menu').attr('data-hidden', '');
			})
		},

		rebaseBg: function() {
			$('[data-block]').each(function(i, el) {
				console.log(i, el)
				$('[data-block-top="' + (i + 1) + '"] > span').html($(el).children().length);

				// $(el).children().each(function(indx, element) {
				// 	$(element).attr({'data-id': indx + 1, style: ''});
				// })
			})
		},

		setStyle: function() {
			function init() {
				$('.table-issues-block > .body > .tb, .table-issues-block > .body').height($(window).height() - 295);
			}

			$(window).resize(function() { init(); });
			init();
		},

		showColumn: function(n, isShow) {
			let selector = $('[data-block="' + n + '"]');
			let selectorTop = $('[ data-block-top="' + n + '"]').children('i');

			if(isShow === 'auto') {
				if(selector.attr('data-hover') == 'true') {
					selector.removeAttr('data-hover');
					selectorTop.addClass('fa-plus').removeClass('fa-minus');
				} else {
					selector.attr('data-hover', true);
					selectorTop.addClass('fa-minus').removeClass('fa-plus')
				}
			} else
				selector.attr('data-hover', isShow);
		},
	}
})(jQuery);
