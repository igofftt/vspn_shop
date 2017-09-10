var
	filCat = {
		addToCart: function(id, type) {
			$.ajax({
				cache: false,

				data: {
					get_data: true,
					id      : id,
					quantity: parseFloat($('.product-' + id + ' .quantity').html()),
					type    : type,
				},

				dataType: 'JSON',

				success: function(data) {
					if(data.result === 'ok') {
						let
							parent = $('.product-' + id);

						if(type === 'add' && parent.data('animations') !== false)
							$('#modal').addClass('active');

						let
							allPrice = 0,
							d,
							t = '',
							tt = '';

						for(var i = 0; data.products.data.length > i; i++) {
							d = data.products.data[i];
							let quantity = data.cart[d.id].quantity || 0;
							let price = (d.price - (d.price / 100 * d.discount || 0)) * quantity;

							t += '<tr>' +
								'<td><h5>' + d.name + '</h5></td>' +
								'<td>1 шт.</td>' +
								'<td>' + price + ' &#8381;' + '</td>' +
								'<td>' +
								'<a href="javascript:void(0)" class="item__remove" ' +
								'onclick="filCat.addToCart(' + d.id + ', \'remove\')">' +
								'<svg> <use xlink:href="/images/site/svg/sprite.svg#icon_waste"/> </svg>' +
								'</a>' +
								'</td>' +
								'</tr>';

							tt += '<tr class="product-' + d.id + '">' +
								'<td>' +
								'<div class="item__description">' +
								'<div class="item__img">';

							if(_.isEmpty(d.file))
								tt += '<div style="background-image: url(\'/images/no_img.png\')"></div>';
							else
							if(d.crop)
								tt += '<div style="background-image: url(\'/images/files/small/' + d.crop +'\')"></div>';
							else
								tt += '<div style="background-image: url(\'/images/files/small/' + d.file +'\')"></div>';

							tt +=	'</div>' +
								'<div class="item__head">' +
								'<h5>' + d.name + '</h5>' +
								'<p>' + d.text + '</p>' +
								'</div>' +
								'</div>' +
								'</td>' +
								'<td>' +
								'<h6>Количество</h6>' +
								'<div class="spinner__counts">' +
								'<button class="minus" onclick="filCat.sumQuantity(' + d.id + ', \'minus\')">' +
								'<i class="icon-minus"></i>' +
								'</button>' +
								'<span class="quantity">' + quantity + '</span>' +
								'<button class="plus" onclick="filCat.sumQuantity(' + d.id + ', \'plus\')">' +
								'<i class="icon-plus"></i>' +
								'</button>' +
								'</td>' +
								'<td>' +
								'<h6>Цена</h6>' +
								'<div class="price">' ;

							if(d.discount > 0)
								tt += '<p><span class="old">' + ((d.price - d.price / 100 * d.discount) * quantity) +
									'</span> &#8381;</p>';

							tt += '<s><span class="new">' + (d.price * quantity) + '</span> &#8381;</s>' +
								'</div>' +
								'</td>' +
								'<td>' +
								'<h6>Удалить</h6>' +
								'<a href="#" class="item__remove" onclick="filCat.addToCart(' + d.id + ', \'remove\')">' +
								'<svg> <use xmlns:xlink="http://www.w3.org/1999/xlink"' +
								' xlink:href="/images/site/svg/sprite.svg#icon_waste"></use> </svg>' +
								'</a>' +
								'</td>' +
								'</tr>';

							allPrice = allPrice + price;
						}

						$('#basketCont').html(t);
						$('.product-cont-big').html(tt);
						$('.selReN > span').html(filCat.pS(allPrice));
						var dn = ' ' + filCat.dN(i,['товар','товара','товаров']);
						$('.result-calc').html('<span>Итог:</span> ' + i + dn + ' на сумму ' + filCat.pS(allPrice) + ' &#8381;');
						$('.moneyTop').html(filCat.pS(allPrice));

						if(!data.products.data.length) {
							$('#basket').addClass('hidden');
							$('#cart-panel-ordering').addClass('hidden');
							$('.moneyTop').html(0);
							$('.product-cont-big').html('<tr><td style="height: 150px"><h3>Корзина пуста</h3></td></tr>');
							$('[name=form_ordering]').addClass('hidden');

							$('[name=form_ordering]').parent().append('<div class="form_ordering_empty"><h3>' +
								'Корзина пуста</h3></div>');
						} else {
							$('.shop-cart > .p').html(data.products.data.length).removeClass('hidden')
							$('#cart-panel-ordering').removeClass('hidden');
							$('#basket').removeClass('hidden');
							$('[name=form_ordering]').removeClass('hidden');
							$('.form_ordering_empty').remove();
						}
					}
				},

				type: 'post',
				url : '/catalog/add_to_cart',
			})
		},

		dN: function declOfNum(number, titles) {
			let cases = [2, 0, 1, 1, 1, 2];
			return titles[ (number%100>4 && number%100<20)? 2 : cases[(number%10<5)?number%10:5] ];
		},

		// helper formatting price
		hlPrice: function hlPrice(s) {
			let separator = ' ';
			return s.replace(/(\d{1,3}(?=(\d{3})+(?:\.\d|\b)))/g,'\$1' + separator);
		},

		initialize: function initialize(data) {
			this.conf = data;
			this.url  = '/';
			this.cont = this.conf.cont;
			this.num  = this.conf.num;
			this.isLoadCat = this.conf.isLoadCat == undefined ? true : this.conf.isLoadCat;
			filCat.selectCategory();
			filCat.loadOnclick();

			// send ordering init
			filCat.sendOrdering();
		},

		// подгружаем обработчки событий
		loadOnclick: function() {
			setTimeout(function() {
				if(this.isLoadCat) {
					$('[name=categories-select]').on('change', function() {
						filCat.selectCategory()
					});

					$('.input-check > label').click(function() {
						filCat.selectCatalogs()
					});

					document.getElementById('price_range').noUiSlider.on('change', () => {
						filCat.selectCatalogs()
					});

					filCat.paginationCatalogs();
				}

				// // init cart min
				filCat.addToCart(0, 'init');
			}, 100)
		},

		// select catalogs
		paginationCatalogs: function() {
			$('.paginator > .next, .paginator > .next-only').click(function() {
				let
					lastPage = $('[name=last-page]').val(),
					nexP = parseInt($('[name=current-page]').val()) + 1;

				if(lastPage >= nexP) {
					$('[name=current-page]').val(_.isNaN(nexP) ? 1 : nexP);
					filCat.selectCatalogs();
				}
			});

			$('.paginator > .prev').click(function() {
				let
					nexP = parseInt($('[name=current-page]').val()) - 1;

				if(nexP >= 1) {
					$('[name=current-page]').val(nexP > 1 ? nexP : 1);
					filCat.selectCatalogs();
				}
			});
		},

		pS: function(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ');
		},

		searchGo: function searchGo(e) {
			if(e.which === 13 || e.keyCode === 13)
				filCat.selectCatalogs();
		},

		selectCatalogs: function() {
			if(!this.isLoadCat)
				return false;

			let
				category = $('[name=category]').val(),
				filterGroup = $('.filterGroup > div.active').data('filterGroup'),
				inputSearch,
				page,
				request;

			if(_.isUndefined(filterGroup))
				filterGroup = -1;

			inputSearch = $('[name=input_search]').val();
			page = $('[name=current-page]').val();

			if(1) {
				request = {
					categories_sub: $('[name=categories_sub]').val(),
					category      : category,
					filter_group  : filterGroup,
					form          : $('[name=filter-form]').serializeArray(),
					input_search  : inputSearch,
					price_max     : $('#width-price-max').val().replace('₽', '').toString().replace(' ', ''),
					price_min     : $('#width-price-min').val().replace('₽', '').toString().replace(' ', ''),
				};

				$(this.cont).css({opacity: 0.3});

				filCat.ajax = $.ajax({
					cache   : false,
					data    : request,
					dataType: 'JSON',

					success: function(data) {
						if(data['result'] === 'ok') {
							let d = [], t = '';
							$('.paginator .current-page').html(page);
							$('.paginator .total > span').html(data.last_page > 0 ? data.last_page : 1);

							$('header .count-t').html('<span class="count">' + data.products.count +
								' ' + filCat.dN(data.products.count, ['товар','товара','товаров']) + '</span>');

							if(page >= data.last_page)
								$('.paginator .next-only').css('display', 'none');
							else
								$('.paginator .next-only').css('display', 'block');

							for(let i = 0; data.products.data.length > i; i++) {
								d = data.products.data[i];

								t += '<li class="product-' + d.id + '">' +
									'<div class="item">' +
									'<a href="/product/' + d.id + '" class="item__description">' +
									'<div class="item__img">';

								if(_.isEmpty(d.file))
									t += '<div style="background-image: url(\'/images/no_img.png\')"></div>';
								else
								if(d.crop)
									t += '<div style="background-image: url(\'/images/files/small/' + d.crop +'\')"></div>';
								else
									t += '<div style="background-image: url(\'/images/files/small/' + d.file +'\')"></div>';

									t += '</div>' +
									'<div class="item__head">' +
									'<h5>' + d.name + '</h5>' +
									'</div>' +
									'<div class="price">' +
									'<span class="new">' + d.price + ' </span>&#8381;';

								if(d.discount > 0)
									t += '<span><span class="old">' + (d.price - d.price / 100 * d.discount) + '</span> &#8381;</span>';

								t += '</div>' +
									'</a>' +
									'<div class="spinner">' +
									'<div class="spinner__counts">' +
									'<button class="minus" onclick="filCat.sumQuantity(' + d.id + ', \'minus\')">' +
									'<i class="icon-minus"></i>' +
									'</button>' +
									'<span class="quantity">10</span>' +
									'<button class="plus" onclick="filCat.sumQuantity(' + d.id + ', \'plus\')">' +
									'<i class="icon-plus"></i>' +
									'</button>' +
									'</div>' +
									'<a href="javascript:void(0)" onclick="filCat.addToCart(' + d.id + ', \'add\')">В корзину</a>' +
									'</div>' +
									'</div>' +
									'</li>';
							}

							t += '<div class="text-center clear">' + data.pagination + '</div>';

							if(!data.products.count)
								t = '<li style="width: 100%">По таким параметрам ничего не найдено ):' +
									'<img src="/images/site/logo.png" class="bgCategories"/></li>';

							$(filCat.num).html(data.products.count);
							$(filCat.cont).html(t);

							console.log('result: ', data)
						}

						$('[name=last-page]').val(data.last_page);
						$('[name=current-page]').val(data.current_page)
						$(filCat.cont).animate({opacity: 1}, 150);
					},

					type: 'post',
					url : '/catalog?page=' + page,
				});
			}
		},

		selectCategory: function() {
			if(!this.isLoadCat)
				return false;

			let category = $('[name=category]').val();

			$.ajax({
				cache   : false,
				data    : {category: category},
				dataType: 'JSON',

				success: function(data) {
					if(data['result'] === 'ok') {
						let
							cat = window.location.href.split('cat=').length > 1 ? window.location.href.split('cat=')[1] : 0,
							curLoc,
							t = '';

						t += '<div class="form-checks sub-categories-cont" style="margin-top: 15px">';

						for(let i = 0; data.subCategories.length > i; i++) {
							let d = data.subCategories[i];

							t += '<div class="input-check" onclick="filCat.selectCatalogs()">' +
								'<input name="categories_sub[]" value="' + d.id + '" type="checkbox" id="check-sub' + d.id + '">' +
								'<label for="check-sub' + d.id + '">' + d.name + '</label>' +
							'</div>';
						}

						setTimeout(function() {
							filCat.ajax.abort();
							$('[for="check-sub' + cat + '"]').click();
						}, 0);

						t += '</div>';
						$('.sub-categories-cont').html(t);
						$('.name-current-cat').html(data.current_category.name);
						$('[name=category]').val(data.current_category.id);
						curLoc = window.location.href.replace('catalog/' + category, 'catalog/' + data.current_category.id);

						try {
							window.history.pushState(null, data.current_category.name, curLoc);
							filCat.selectCatalogs();
							return;
						} catch(e) {}

						window.location.hash = '#' + curLoc;
					}
				},

				type: 'post',
				url : '/catalog/get_category_and_sub',
			});
		},

		sendOrdering: function() {
			let
				vApartment,
				vCite,
				vEmail,
				vHome,
				vName,
				vPhone,
				vStreet,
				vSurname;

			function init() {
				vApartment = new Validators.Field({
					check_validate: 'required|min_1',
					element       : document.getElementById('apartment'),
					nameField     : 'Квартира',
					only_error    : true,
				});

				vCite = new Validators.Field({
					check_validate: 'required|min_3',
					element       : document.getElementById('cite'),
					nameField     : 'Город',
					only_error    : true,
				});

				vEmail = new Validators.Field({
					check_validate: 'required|email',
					element       : document.getElementById('email'),
					nameField     : 'Электронная почта',
					only_error    : true,
				});

				vStreet = new Validators.Field({
					check_validate: 'required|min_3',
					element       : document.getElementById('street'),
					nameField     : 'Улица',
					only_error    : true,
				});

				vHome = new Validators.Field({
					check_validate: 'required|min_1',
					element       : document.getElementById('home'),
					nameField     : 'Дом',
					only_error    : true,
				});

				vName = new Validators.Field({
					check_validate: 'required|min_3',
					element       : document.getElementById('name'),
					nameField     : 'Имя',
					only_error    : true,
				});

				vSurname = new Validators.Field({
					check_validate: 'required|min_3',
					element       : document.getElementById('surname'),
					nameField     : 'Фамилия',
					only_error    : true,
				});

				vPhone = new Validators.Field({
					check_validate: 'required|phoneMobile',
					element       : document.getElementById('phone'),
					nameField     : 'Телефон',
					only_error    : true,
				});
			}

			filCat.send_app = function() {
				let
					valid = true;

				vApartment.validate();
				vCite.validate();
				vEmail.validate();
				vStreet.validate();
				vHome.validate();
				vName.validate();
				vSurname.validate();
				vPhone.validate();

				setTimeout(function() {
					valid = valid ? vApartment.valid() : valid;
					valid = valid ? vCite.valid() : valid;
					valid = valid ? vEmail.valid() : valid;
					valid = valid ? vStreet.valid() : valid;
					valid = valid ? vHome.valid() : valid;
					valid = valid ? vName.valid() : valid;
					valid = valid ? vSurname.valid() : valid;
					valid = valid ? vPhone.valid() : valid;

					if(valid) {
						$.ajax({
							cache: false,

							data: {
								apartment: $('[name="apartment"]').val(),
								cite     : $('[name="cite"]').val(),
								email    : $('[name="email"]').val(),
								home     : $('[name="home"]').val(),
								name     : $('[name="name"]').val(),
								phone    : $('[name="little_description"]').val(),
								street   : $('[name="street"]').val(),
								surname  : $('[name="surname"]').val(),
							},

							dataType: 'JSON',

							success: function(data) {
								if(data.result === 'ok') {
									$('#modal_thanks').addClass('active');
									$('.product-cont-big').html('<tr><td style="height: 150px"><h3>Корзина пуста</h3></td></tr>');
									vApartment.cssReset(true);
									vCite.cssReset(true);
									vEmail.cssReset(true);
									vStreet.cssReset(true);
									vHome.cssReset(true);
									vName.cssReset(true);
									vSurname.cssReset(true);
									vPhone.cssReset(true);

									// update cart
									filCat.addToCart(0, 'init');
								}
							},

							type: 'post',
							url : '/send_ordering',
						});
					}
				}, 300);
			};

			return init();
		},

		/**
		 * plus or minus weight meat
		 * @param id
		 * @param type
		 */
		sumQuantity: function(id, type) {
			let
				currentPriceNew = $('.product-' + id + ' .new'),
				currentPriceOld = $('.product-' + id + ' .old'),
				currentQuantityCont = $('.product-' + id + ' .quantity'),
				quant = 0;

			let
				currentQuantity = parseFloat(currentQuantityCont.html().replace(' ', ''));

			if(type === 'plus') {
				quant = (parseFloat(currentQuantityCont.html().replace(' ', '')) + 1).toFixed(0);
				currentQuantityCont.html(quant);
			} else {
				quant = (parseFloat(currentQuantityCont.html().replace(' ', '')) - 1).toFixed(0);

				if(parseFloat(currentQuantityCont.html().replace(' ', '')) > 1)
					currentQuantityCont.html(quant);
			}

			if(quant > 1) {
				currentPriceNew.html((parseFloat(currentPriceNew.html()) / currentQuantity * quant).toFixed(0));
				currentPriceOld.html((parseFloat(currentPriceOld.html()) / currentQuantity * quant).toFixed(0));
			}
		},
	};
