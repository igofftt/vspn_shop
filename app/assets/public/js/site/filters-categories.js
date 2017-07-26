var
	filCat = {
		addToCart: function(id, type) {
			$.ajax
			({
				cache: false,

				data: {
					get_data: true,
					id      : id,
					type    : type,
					weights : (parseFloat($('.product-' + id + ' .weight > span').html()) * 1000).toFixed(2),
				},

				dataType: 'JSON',

				success: function(data) {
					if(data.result === 'ok') {
					}
				},

				type: 'post',
				url : '/catalog/add_to_cart',
			})
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
			filCat.loadOnclick()
		},

		// подгружаем обработчки событий
		loadOnclick: function loadOnclick() {
			setTimeout(function() {
				$('.filterGroup > div').click(function() {
					$('.filterGroup > div').removeClass('active');
					$(this).addClass('active');
					filCat.selectCatalogs();
				});

				$('.iCheck-helper').click(function() {
					filCat.selectCatalogs();
				});

				filCat.paginationCatalogs();
			}, 100)
		},

		// select catalogs
		paginationCatalogs: function() {
			$('.paginator > .next, .paginator > .next-only').click(function() {
				let
					currentPage = parseInt($('[name=current-page]').val()),
					lastPage = $('[name=last-page]').val(),
					nexP = currentPage + 1;

				if(lastPage >= nexP) {
					$('[name=current-page]').val(_.isNaN(nexP) ? 1 : nexP);
					filCat.selectCatalogs();
				}
			});

			$('.paginator > .prev').click(function() {
				let
					currentPage = parseInt($('[name=current-page]').val()),
					nexP = currentPage - 1;

				if(nexP >= 1) {
					$('[name=current-page]').val(nexP > 1 ? nexP : 1);
					filCat.selectCatalogs();
				}
			});
		},

		searchGo: function searchGo(e) {
			if(e.which === 13 || e.keyCode === 13)
				filCat.selectCatalogs();
		},

		selectCatalogs: function() {
			let filterGroup, inputSearch, page, request;
			filterGroup = $('.filterGroup > div.active').data('filterGroup');

			if(_.isUndefined(filterGroup))
				filterGroup = -1;

			inputSearch = $('[name=input_search]').val();
			page = $('[name=current-page]').val();

			if(1) {
				request = {
					filter_group: filterGroup,
					input_search: inputSearch,
				};

				$(this.cont).css({opacity: 0.3});

				$.ajax({
					cache   : false,
					data    : request,
					dataType: 'JSON',

					success: function(data) {
						if(data['result'] === 'ok') {
							let d = [], t = '';
							$('.paginator .current-page').html(page);
							$('.paginator .total > span').html(data.last_page);

							if(page >= data.last_page)
								$('.paginator .next-only').css('display', 'none');
							else
								$('.paginator .next-only').css('display', 'block');

							for(let i = 0; data.products.data.length > i; i++) {
								d = data.products.data[i];

								t += '<li>' +
									'<div class="item products-' + d.id + '">' +
									'<a href="/product/' + d.id + '" class="item__description">' +
									'<div class="item__img">' +
									'<div class="_mn" style="background-image: url(\'/images/site/items/item01.png\')"></div>' +
									'<div class="_hv" style="background-image: url(\'/images/site/items/item02.png\')"></div>' +
									'</div>' +
									'<div class="item__head">' +
									'<h5>' + d.name + '</h5>' +
									'</div>' +
									'<div class="price">' +
									'<span class="new">' + d.price + ' &#8381;</span>';

								if(d.discount > 0)
									t += '<span class="old">' + (d.price - d.price / 100 * d.discount) + ' &#8381;</span>';

								t += '</div>' +
									'</a>' +
									'<div class="spinner">' +
									'<div class="spinner__counts">' +
									'<button class="minus" onclick="filCat.sumQuantity(' + d.id + ', \'minus\')" >' +
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

							if(data.products.total === 0)
								t = '<p>По таким параметрам ничего не найдено ):' +
									'<img src="/images/shop/logo.png" class="bgCategories"/></p>';

							$(filCat.num).html(data.products.total);
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

		/**
		 * plus or minus weight meat
		 * @param id
		 * @param type
		 */
		sumQuantity: function(id, type) {
			let
				currentQuantityCont = $('.products-' + id + ' .quantity'),
				quant;

			if(type === 'plus') {
				quant = (parseFloat(currentQuantityCont.html()) + 1).toFixed(0);
				currentQuantityCont.html(quant);
			} else {
				quant = (parseFloat(currentQuantityCont.html()) - 1).toFixed(0);

				if(parseFloat(currentQuantityCont.html()) > 1)
					currentQuantityCont.html(quant);
			}
		},
	};
