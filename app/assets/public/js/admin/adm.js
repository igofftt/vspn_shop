(function() {
	$.adm = {
		ch: function ch(c, title) {
			$('.sass').html('<p class="alert" style="background: #d2d6de">Выбран пункт: ' + title + '</p>');
			$('.id_mt').val(c);

			$('.inp_edit_' + c).html('<input ' +
				'type="radio" ' +
				'checked="checked" ' +
				'onclick="$.adm.inp_edit(' + c + ', \'' + title + '\')" ' +
				'value="' + c+ '" ' +
				'class="inp_edit" ' +
				'/>');
		},

		close_mt: function close_mt() {
			$('.id_mt').val(0);
			$('input[type="radio"]').iCheck('uncheck');
			$('.sass').slideUp(300);
			setTimeout('$(".sass").html("").show(0)', 300);
		},

		editM: function(t) {
			if(t === 'show') {
				$('body').css({overflow: 'hidden'});
				$('#container-editor').animate({opacity: 1, right: 0}, 500);
				$('body').append('<div class="bg-fon-free-0" onclick="$.adm.showFreeClose()"></div>');

				setTimeout(function() {
					$('.container-editor .bottom-panel').animate({bottom: 0}, 800);

					//                $('.container-editor .bottom-panel').width($('.container-editor .body').width() + 30);
				}, 400)

				setTimeout(function() {
					$('.container-editor .body').height($(window).height() - 85);
				}, 1300)

				$(window).resize(function() {
					$('.container-editor .body').height($(window).height() - 85);
				})
			}

			if(t === 'hide') {
				$('.bg-fon-free-0').remove();
				$('body').css({overflow: 'auto'});

				$('#container-editor').animate({
					opacity: 0,
					right  : '-100%',
				}, 500);

				$('.container-editor .body').height($(window).height());
				$('#container-editor .body').html('');
				$.adm.hideFonEdit();
			}
		},

		elementsLoad: function elementsLoad() {
			$('input[type="radio"]').on('ifChanged', function(event) {
				$.adm.inp_edit(event['target']['id'], event['target']['title'])
			});

			$('input[name="id_m"]').on('click', function(event) {
				$('input[type="radio"]').removeAttr('checked');

				$(':radio[name=inp_edit]:checked').each(function() {
					// on future checkbox select to mass edit
					$.adm.conf.set('checked_set', event['target']['val']);
				});

				$.adm.inp_edit(event['target']['id'], event['target']['title'])
			});
		},

		hideFonEdit: function() {
			$('.bg-fon-edit-is, .bg-fon-free').animate({opacity: 0}, 300);

			setTimeout(function() {
				$('.bg-fon-edit-is, .bg-fon-free').remove();
			}, 400)
		},

		htmlQuotes: function htmlQuotes(str) {
			str = str.split('\'').join('&quot');
			str = str.split('\"').join('&quot');
			str = str.split('<').join('&lt');
			str = str.split('>').join('&gt');
			return str;
		},

		initialize: function initialize(data) {
			this.conf = new Map(data.pram);
			$.adm.loadOnclick();

			$('body').append(
				'<div class="container-editor" id="container-editor">' +
				'<div class="">' +
				'<div class="body"></div>' +
				'<div class="bg-fon-edit"></div>' +
				'</div>' +
				'</div>' +

				'<div class="modal fade" id="modalDel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"' +
				' aria-hidden="true">' +
				'<div class="modal-dialog">' +
				'<div class="modal-content">' +
				'<div class="modal-header">' +
				'<button type="button" class="close" data-dismiss="modal" aria-label="Close">' +
				'<span aria-hidden="true">&times;</span>' +
				'</button>' +
				'<h4 class="modal-title modal-title-mess" id="myModalLabel">Удалить</h4>' +
				'</div>' +
				'<div class="modal-body modal-body-mess">' +
				'Вы уверены?' +
				'</div>' +
				'<div class="modal-footer">' +
				'<button type="button" class="btn btn-default" data-dismiss="modal">Закрыть</button>' +
				'<button type="button" class="btn btn-danger delbMod">Удалить</button>' +
				'</div>' +
				'</div>' +
				'</div>' +
				'</div>')
		},

		inp_edit: function inp_edit(val, title) {
			title = this.htmlQuotes(title);

			$('.sass').html('<p class="alert" style="background: #d2d6de">' +
				'Выбран пункт: ' + title +
				'<button onclick="$.adm.close_mt()" class="btn btn-default" style="float: right; margin: -7px -7px 0px 0px;">' +
				'<span class="glyphicon glyphicon-remove"></span>' +
				'</button>' +
				'</p>');

			$('.id_mt').val(val);
		},

		loadOnclick: function loadOnclick() {
			this.conf.get('elementsLoad') && this.elementsLoad();

			$('.edit-link').click(function() {
				let
					id = $(this).data('id'),
					table = $(this).data('table');

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
			});
		},

		makeD: function makeD(v) {
			let checked_set = $('.id_mt').val();

			if(checked_set === '' || checked_set === 0) {
				$('.error').html('<div class="alert alert-danger alert-dismissable">Выберите пункт меню</dev>');
				setTimeout('$(".error").hide(300)', 2500);
				setTimeout('$(".error").html("").show(0)', 3000);
			} else {
				if(v === 'edit') {
					window.location = '/admin/site/update/' + this.conf.get('link_module') + '/' + checked_set
				}

				if(v === 'delete') {
					$.adm.rowDelete(checked_set, '\''+ this.conf.get('link_module') + '\'')
				}

				if(v === 'copy') {
					window.location = '/admin/site/copy/' + this.conf.get('link_module') + '/' + checked_set
				}
			}

			$('.select [value=\'0\']').attr('selected', 'selected');
			document.getElementById('select1').options[0].selected = true;
		},

		rowDelete: function rowDelete(id, t, n) {
			$('#modalDel').modal('show');
			$('.delbMod').attr('onclick','$.adm.rowDeleteOk('+ id +', '+ t +', \''+ n +'\')');
			$('.modal-body-mess').html('Вы уверены?');
			$('.modal-title-mess').html('Удалить');
		},

		rowDeleteOk: function rowDeleteOk(id, t, n) {
			let dataString = 'id=' + id + '&table=' + t + '&name=' + n;

			$.ajax({
				cache   : false,
				data    : dataString,
				dataType: 'JSON',

				success: function(data) {
					if(data['result'] === 'ok') {
						if(data['mess'] === '' || data['mess'] === 'ok') {
							$('#modalDel').modal('hide');
							$('.flt-'+id).parent('div').parent('td').parent('tr').remove();
							$.adm.close_mt();
						}
					}

					if(data['mess'] !== '' && data['mess'] != undefined) {
						$('.modal-body-mess').html(data['mess']);

						if(data['title'] !== '') {
							$('.modal-title-mess').html(data['title']);
						}
					}
				},

				type: 'post',
				url : '/admin/_tools/rowDelete',
			});
		},

		showFreeClose: function() {
			let body = $('body'), panel = $('.container-editor .bottom-panel');
			body.append('<div class="bg-fon-free"></div>');
			panel.clone().addClass('bg-fon-edit-is').appendTo('body');

			$('.bg-fon-edit-is').append(
				'<button class="close" onclick="$.adm.hideFonEdit()"><i class="fa fa-close"></i></button>' +
				'<a class="btn btn-danger btn-sm" onclick="$.adm.editM(\'hide\')" type="button" href="javascript:void(0)">' +
				'Не сохранять' +
				'</a>',
			);

			$('.bg-fon-edit-is > .loader').html('<p>Закрыть без сохранения?</p>');
		},

		url: '/',
	}
})(jQuery);
