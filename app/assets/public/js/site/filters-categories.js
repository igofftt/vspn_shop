var
	filCat = {

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
			}, 100)
		},

		searchGo: function searchGo(e) {
			if(e.which === 13 || e.keyCode === 13)
				filCat.selectCatalogs();
		},

		// select catalogs
		selectCatalogs: function() {
			let filterGroup, inputSearch, page, request;
			filterGroup = $('.filterGroup > div.active').data('filterGroup');

			if(_.isUndefined(filterGroup))
				filterGroup = -1;

			inputSearch = $('[name=input_search]').val();
			page = $('[name=pagination-page]').val();

			if(1) {
				request = {
					filter_group: filterGroup,
					input_search: inputSearch,
				};

				$(this.cont).html('<p>Загрузка...</p>');

				$.ajax({
					cache   : false,
					data    : request,
					dataType: 'JSON',

					success: function(data) {
						if(data['result'] === 'ok') {
							let d = [], nexP = 1, t = '';

							$('.paginator .current-page').html(page);
							$('.paginator .total > span').html(data.last_page);

							if(page <= 1)
								$('.paginator .next-only').css('display', 'none');
							else
								$('.paginator .next-only').css('display', 'block');

							for(let i = 0; data.products.data.length > i; i++)
							{
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
									'<span class="new">1 500 &#8381;</span>' +
									'<span class="old">3 000 &#8381;</span>' +
									'</div>' +
									'</a>' +
									'<div class="spinner">' +
									'<div class="spinner__counts">' +
									'<button class="minus"><i class="icon-minus"></i></button>' +
									'<span>10</span>' +
									'<button class="plus"><i class="icon-plus"></i></button>' +
									'</div>' +
									'<a href="#">В корзину</a>' +
									'</div>' +
									'</div>' +
									'</li>';
							}

							t += '<div class="text-center clear">' + data.pagination + '</div>';

							if(data.products.total === 0)
								t = '<p>По таким параметрам ничего не найдено ):</p>';

							$(filCat.num).html(data.products.total);
							$(filCat.cont).html(t);
							console.log('result: ', data)

							$('.paginator > .next, .paginator > .next-only').click(function() {
								nexP = data.products.current_page + 1;
								$('[name=pagination-page]').val(_.isNaN(nexP) ? 1 : nexP);
								filCat.selectCatalogs();
							});

							$('.paginator > .prev').click(function() {
								nexP = data.products.current_page - 1;
								$('[name=pagination-page]').val(nexP > 1 ? nexP : 1);
								filCat.selectCatalogs();
							});

							$('.pagination').click(function(ev) {
								page = ev.target.innerText;

								if(data.products.current_page === page)
									return false;

								return false;
							}, 100)
						}
					},

					type: 'post',
					url : '/catalog?page=' + page,
				});
			}
		},
	};
