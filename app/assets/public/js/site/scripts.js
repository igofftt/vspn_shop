$(document).ready(function() {
	/* custom selects*/
	function customSelects() {
		$('.custom-select').select2({
			width: '100%',
		});
	}

	/* custom range */
	function customRange() {
		let
			$range_price = document.getElementById('price_range'),
			$range_width = document.getElementById('width_range');

		let
			widthRangeMax = parseInt($('[name=width-range-max]').val()),
			widthRangeMin = parseInt($('[name=width-range-min]').val());

		console.log(widthRangeMax)

		noUiSlider.create($range_width, {
			connect : [true, false],
			range   : {max: [widthRangeMax], min: [widthRangeMin]},
			start   : [widthRangeMax/2],
			step    : 1,
			tooltips: [wNumb({decimals: 0, postfix: ' mm', thousand: '&nbsp;'})],
		});

		let
			inputMin = document.getElementById('width-price-min'),
			inputMax = document.getElementById('width-price-max'),
			inputs = [inputMin, inputMax];

		noUiSlider.create($range_price, {
			connect: [false, true, false],

			format: wNumb({
				decimals: 0,
				postfix : ' ₽',
				thousand: ' ',
			}),

			range: {max: [parseFloat(inputMax.value)], min: [parseFloat(inputMin.value)]},
			start: [0, (inputMax.value/2)],
			step : 10,
		});

		$range_price.noUiSlider.on('update', (values, handle) => {
			inputs[handle].value = (values[handle]);
		});

		/* change input in range */
		function setSliderHandle(i, value) {
			let r = [null,null];
			r[i] = value;
			$range_price.noUiSlider.set(r);
		}

		inputs.forEach((input, handle) => {
			input.addEventListener('change', function() {
				setSliderHandle(handle, this.value);
			});

			input.addEventListener('keydown', e => {
				switch(e.which) {
				case 13:
					setSliderHandle(handle, this.value);
					break;
				}
			});
		});
	}

	/* spinner counts */
	function spinners() {
		let $spinnerBox = $('.spinner__counts');

		$spinnerBox.each(function() {
			let $thisSpinner = $(this);
			let _current = $thisSpinner.find('span').text();

			$thisSpinner.find('.minus').click(function() {
				if(_current > 0) {
					_current--;
					$thisSpinner.find('span').text(_current);
				}
			});

			$thisSpinner.find('.plus').click(function() {
				_current++;
				$thisSpinner.find('span').text(_current);
			})
		})
	}

	/* catalog view */
	$('.view i').click(function() {
		$('.view i').removeClass('active');
		$(this).addClass('active');

		if($(this).hasClass('list'))
			$('.catalog__content').addClass('list_view');
		else
			$('.catalog__content').removeClass('list_view')
	});

	/* grid font */
	let font = 1;

	function gridFont() {
		let winWidth = $(window).width();

		if(winWidth > 1800)
			font = 1;

		else {
			font = winWidth/1800;
		}

		$('.grid').css('font-size',font+'em');
	}

	if($('.custom-select').length > 0)
		customSelects();

	if($('.form-range').length > 0)
		customRange();

	if($('.spinner__counts').length > 0)
		spinners();

	if($('.grid').length > 0)
		gridFont();

	$(window).resize(function() {
		if($('.grid').length > 0)
			gridFont();
	});

	// tabs
	$('.tab').click(function() {
		let
			currentTab = $(this),
			parent = currentTab.parent(),
			parent_parent = parent.parent();

		if(parent_parent.hasClass('product__tabs')) {
			parent.children().removeClass('current');
			parent_parent.children('.product__tabs_main').removeClass('current');
			currentTab.addClass('current');

			parent_parent.children('.product__tabs_main').map((t, r) => {
				if($(r).data('tab') === currentTab.data('tab'))
					$(r).addClass('current');
			})
		}
	})

	let findBySel = function(el, nameSearch, selector, searchBy) {
		let
			result = el,
			_selector = selector || 'tagName';

		while(((result || {})[_selector] || 'undefined').toLowerCase() !== nameSearch.toLowerCase()) {
			if(!result) {
				break;
			}

			result = (result ||{})[searchBy ? searchBy + 'Node' : 'parentNode'];
		}

		return result;
	};

	let closeDropdown = function(el) {
		let element = findBySel(el.target, 'dropdown', 'id');

		if(!element) {
			$('#' + $('[data-dropdown]').data('dropdown')).removeClass('show');
			$('body').off('click', closeDropdown);
		}
	};

	$('[data-dropdown]').click(function() {
		$('#' + $(this).data('dropdown')).addClass('show');
		$('body').off('click', closeDropdown);
		$('body').on('click', closeDropdown);
	});
});
