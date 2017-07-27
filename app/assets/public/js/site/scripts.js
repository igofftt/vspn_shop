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

		noUiSlider.create($range_width, {
			connect : [true, false],
			range   : {max: [100], min: [0]},
			start   : [70],
			step    : 5,
			tooltips: [wNumb({decimals: 0, postfix: ' mm', thousand: '&nbsp;'})],
		});

		let
			$input0 = document.getElementById('input-with-keypress-0'),
			$input1 = document.getElementById('input-with-keypress-1'),
			inputs = [$input0, $input1];

		noUiSlider.create($range_price, {
			connect: [false, true, false],

			format: wNumb({
				decimals: 0,
				postfix : ' ₽',
				thousand: ' ',
			}),

			range: {max: [20000], min: [0]},
			start: [0, 10000],
			step : 100,
		});

		$range_price.noUiSlider.on('update', (values, handle) => {
			inputs[handle].value = values[handle];
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
	})
});
