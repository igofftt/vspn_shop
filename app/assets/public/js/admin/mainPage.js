(function() {
	$.mainp = {
		changeType: function(type) {
			let
				block_1_1 = $('.block_1_1').clone()[0].outerHTML,
				block_1_2 = $('.block_1_2').clone()[0].outerHTML,
				block_2 = $('.block_2').clone()[0].outerHTML,
				block_3_1 = $('.block_3_1').clone()[0].outerHTML,
				block_3_2 = $('.block_3_2').clone()[0].outerHTML,
				currentForm = $('[name=formMainPage]').serializeArray(),
				tr1 = $('.table-page .tr1'),
				tr2 = $('.table-page .tr2');

			if(parseInt(type) === 1) {
				tr1.html(block_1_1 + block_2 + block_3_1);
				tr2.html(block_1_2 + block_3_2);
			}

			if(parseInt(type) === 2) {
				tr1.html(block_2 + block_1_1 + block_3_1);
				tr2.html(block_1_2 + block_3_2);
			}

			if(parseInt(type) === 3) {
				tr1.html(block_1_1 + block_3_1 + block_2);
				tr2.html(block_3_2 + block_1_2 );
			}

			setTimeout(function() {
				_.map(currentForm, function(r) {
					document.getElementsByName(r.name)[0].value = r.value;
				});
			}, 100)
		},

		fileManager: function(name) {
			$.ajax({
				cache: false,

				data: {
					id_album  : '1',
					name_table: 'main_page',
				},

				dataType: 'html',

				success: function(data) {
					$('#fileModal .modal-body').html(data);
					$('#fileModal').modal('show');

					$('img').click(function() {
						let
							img = $(this).attr('src').replace('small', 'big');

						$('[name="text[' + name + '][img]"]').val(img);
						$('.' + name).css({backgroundImage: 'url(\'' + img + '\')'});
						$('#fileModal').modal('hide');
					})
				},

				type: 'post',
				url : '/admin/file_manager/show_loader',
			})
		},

		initialize: function initialize(data) {
			this.conf = new Map(data.pram);
			$.mainp.loadOnclick();
			this.makeupFields()
		},

		loadOnclick: function() {

		},

		makeupFields: function() {
			let
				data = JSON.parse(this.conf.get('data')),
				type_1 = ['block_1_1', 'block_2', 'block_3_1', 'block_1_2', 'block_3_2'],
				type_2 = ['block_2', 'block_1_1', 'block_3_1', 'block_1_2', 'block_3_2'],
				type_3 = ['block_1_1', 'block_3_1', 'block_2', 'block_3_2', 'block_1_2'],
				typeTmp = [];

			_.map(data.text, function(r, k) {
				typeTmp.push(k);
				document.getElementsByName('text[' + k + '][link]')[0].value = r.link || '';
				document.getElementsByName('text[' + k + '][img]')[0].value = r.img || '';
				document.getElementsByName('text[' + k + '][text]')[0].value = r.text || '';
				$('.' + k).css({backgroundImage: 'url(\'' + r.img + '\')'});
			});

			if(_.isEqual(typeTmp, type_1))
				$('.select2').val(1).trigger('change');

			if(_.isEqual(typeTmp, type_2))
				$('.select2').val(2).trigger('change');

			if(_.isEqual(typeTmp, type_3))
				$('.select2').val(3).trigger('change');
		},
	}
})(jQuery);
