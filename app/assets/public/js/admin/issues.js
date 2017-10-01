var
	issues = {
		initialize: function initialize(data) {
			this.conf = new Map(data.params);
			this.loadIssues();
			this.loadProducts();
			this.loadOnclick();
		},

		/**
		 * Function load Issues
		 */
		loadIssues: function() {
			let
				plugins = this.conf.get('plugins'),
				pluginsLang = this.conf.get('plugins-lang');

			$.ajax({
				cache   : false,
				data    : {table: issues.conf.get('table')},
				dataType: 'JSON',

				success: function(data) {
					let
						body = data.data || {},
						text,
						type = ['Новая заявка', 'Нет в наличии', 'В отправке', 'В наличии', 'Заказ отправлен', 'Доставлено'];

					if(_.isEmpty(body))
						return false;

					_.map(pluginsLang, (v, k) => {
						text = _.unescape(body[k]);

						try {
							text = JSON.parse(text);

							if(text) {
								$('[name="pl[' + k + '][ru]"]').val(_.unescape(text.ru));
								$('[name="pl[' + k + '][en]"]').val(_.unescape(text.en));
							}
						} catch(err) {

							// обработка ошибки
						}
					});

					_.map(plugins, (v, k) => {
						text = body[k];

						if((v.plugins || {}).typeField === 'select' && text !== 'NaN') {
							if((v.plugins || {}).name === 'status') {
								$('.select2-status').select2({width: '100%'});
								$('#select' + k.ucfirst()).val(text ? text : 0).trigger('change');
							} else {
								$('.select2').select2({width: '100%'});
								$('#select' + k.ucfirst()).val(text ? text : 0).trigger('change');
							}
						} else {
							$('[name="pl[' + k + ']"]').val(_.unescape(text));
						}
					});

					_.map(data.statuses, v => {
						$('#statuses').append('<li>Статус: ' + type[v.status] + ' Дата: ' + v.created_at + '</li>')
					});
				},

				type: 'post',
				url : '/admin/load-update/issues_json/' + issues.conf.get('id'),
			});
		},

		loadOnclick: function() {
			String.prototype.ucfirst = function() {
				return this.charAt(0).toUpperCase() + this.substr(1, this.length - 1);
			}
		},

		/**
		 * Function load Issues
		 */
		loadProducts: function() {
			$.ajax({
				cache   : false,
				data    : {table: issues.conf.get('table')},
				dataType: 'JSON',

				success: function(data) {
					if(data.result === 'ok') {
						var html = '';

						_.map(data.orders, v => {
							let price = (v.current_price - (v.current_price / 100 * v.current_discount || 0)) * v.count;

							html += '<li class="list-dr lists" id="orders-' + v.id + '">' +
								'<div class="top-fixed">' +
								'<a href="javascript:void(0)" onclick="$.adm.rowDelete(' + v.id + ', \'orders\')">' +
								'<i class="glyphicon glyphicon-remove"></i>' +
								'</a>' +
								'</div>' +

								'<div class="edit-link" data-table="products" data-id="' + v.id + '">' +
								'<div class="row">' +
								'<div class="col col-4 left">' +
								'<div class="thumbnail-old">';

							if(v.file)
								if(v.crop)
									html += '<img src="/images/files/small/' + v.crop + '" />';
								else
									html += '<img src="/images/files/small/' + v.file + '" />';
							else
								html += '<img src="/images/no_img.png" />';

							html += '</div>' +
							'</div>' +
							'<div class="col col-8 right">' +
							'<a href="javascript:void(0)" data-table="products">' +
							v.name +
							'</a>' +
							'<div>Цена: ' + v.current_price + '</div>' +
							'<div>Артикул: #' + (v.vendor_code ? v.vendor_code : v.id_parent) + '</div>' +
								'<hr style="border-color: red"/>' +
								'Количество: ' + v.count + '<br />' +
								'Сумма: ' + price + '<br />' +
								'</div>' +
								'</div>' +
								'</div>' +

								'<div class="text-right">' +
								'<a target="_blank" href="/product/' + v.id_parent + '"><i class="glyphicon glyphicon-share"></i></a>' +
								'</div>' +
								'</li>';
						});

						$('#ordering').html(html)
					}
				},

				type: 'post',
				url : '/admin/load-update/products_json/' + issues.conf.get('id'),
			});
		},

	};
