$(document).ready(function(){

    /* custom selects*/
    function customSelects() {
        $('.custom-select').each(function () {
            $(this).selectbox();
        })
    }

    /* custom range */

    function customRange() {
        var $range_width = document.getElementById('width_range'),
            $range_price = document.getElementById('price_range');

        noUiSlider.create($range_width, {
            start: [70],
            step: 5,
            connect: [true, false],
            tooltips: [ wNumb({ decimals: 0, thousand: '&nbsp;', postfix: ' mm' }) ],
            range: {
                'min': [ 0 ],
                'max': [ 100 ]
            }
        });

        var $input0 = document.getElementById('input-with-keypress-0'),
            $input1 = document.getElementById('input-with-keypress-1');
        var inputs = [$input0, $input1];

        noUiSlider.create($range_price, {
            start: [0, 10000],
            step: 100,
            connect: [false, true, false],
            range: {
                'min': [ 0 ],
                'max': [ 20000 ]
            },
            format: wNumb({
                decimals: 0,
                thousand: ' ',
                postfix: ' ₽'
            })
        });

        $range_price.noUiSlider.on('update', function( values, handle ) {
            inputs[handle].value = values[handle];
        });

        /* change input in range */

        function setSliderHandle(i, value) {
            var r = [null,null];
            r[i] = value;
            $range_price.noUiSlider.set(r);
        }

        inputs.forEach(function(input, handle) {

            input.addEventListener('change', function(){
                setSliderHandle(handle, this.value);
            });

            input.addEventListener('keydown', function( e ) {

                switch ( e.which ) {
                    case 13:
                        setSliderHandle(handle, this.value);
                        break;
                }
            });
        });

    }

    /* spinner counts */

    function spinners() {

        var $spinnerBox = $('.spinner__counts');

        $spinnerBox.each(function () {
            var $thisSpinner = $(this);
            var _current = $thisSpinner.find('span').text();

            $thisSpinner.find('.minus').click(function () {
                if(_current > 0){
                    _current--;
                    $thisSpinner.find('span').text(_current);
                }
            })
            $thisSpinner.find('.plus').click(function () {
                _current++;
                $thisSpinner.find('span').text(_current);
            })
        })
    }


    /* catalog view */

    $('.view i').click(function () {
        $('.view i').removeClass('active');
        $(this).addClass('active');
        if($(this).hasClass('list')){
            $('.catalog__content').addClass('list_view')
        }
        else {
            $('.catalog__content').removeClass('list_view')
        }
    })


    /* grid font */

    var font = 1;
    function gridFont(){
        var winWidth = $(window).width();
        if(winWidth > 1800){
            font = 1;
        }
        else {
            var k = winWidth/1800;
            font = k;
        }
        $('.grid').css('font-size',font+'em');
    }





    if($('.custom-select').length > 0){
        customSelects();
    }
    if($('.form-range').length > 0){
        customRange();
    }
    if($('.spinner__counts').length > 0){
        spinners();
    }
    if($('.grid').length > 0){
        gridFont()
    }


    $(window).resize(function(){
        if($('.grid').length > 0){
            gridFont()
        }
    })

});