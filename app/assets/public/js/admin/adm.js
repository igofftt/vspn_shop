(function() {
	$.adm = {
		url: '/',

		initialize: function initialize(data) {
			this.conf = new Map(data.pram);
			$.adm.loadOnclick();

			$('body').append(
				'<div class="modal fade" id="modalDel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
				'<div class="modal-dialog">' +
				'<div class="modal-content">' +
				'<div class="modal-header">' +
				'<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>' +
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

		loadOnclick: function loadOnclick() {
			this.conf.get('elementsLoad') && this.elementsLoad();
		},

		makeD: function makeD(v) {

			var checked_set =  $(".id_mt").val();

			if(checked_set == '' || checked_set == 0) {
				$(".error").html('<div class="alert alert-danger alert-dismissable">Выберите пункт меню</dev>');
				setTimeout('$(".error").hide(300)', 2500);
				setTimeout('$(".error").html("").show(0)', 3000);
			} else {
				if(v == 'edit') {
					window.location = "/admin/site/update/" + this.conf.get('link_module') + "/" + checked_set
				}

				if(v == 'delete') {
					$.adm.rowDelete(checked_set, '\''+ this.conf.get('link_module') + '\'')
				}

				if(v == 'copy') {
					window.location = "/admin/site/copy/" + this.conf.get('link_module') + "/" + checked_set
				}
			}

			$(".select [value='0']").attr("selected", "selected");
			document.getElementById('select1').options[0].selected = true;
		},

		inp_edit: function inp_edit(val, title) {
			title = this.htmlQuotes(title);

			$(".sass").html('<p class="alert" style="background: #d2d6de">' +
				'Выбран пункт: ' + title +
				'<button onclick="$.adm.close_mt()" class="btn btn-default" style="float: right; margin: -7px -7px 0px 0px;">' +
				'<span class="glyphicon glyphicon-remove"></span>' +
				'</button>' +
				'</p>');

			$(".id_mt").val(val);
		},

		close_mt: function close_mt() {
			$(".id_mt").val(0);
			$('input[type="radio"]').iCheck('uncheck');

			$(".sass").slideUp(300);
			setTimeout('$(".sass").html("").show(0)', 300);
		},

		ch: function ch(c, title) {
			$(".sass").html('<p class="alert" style="background: #d2d6de">Выбран пункт: ' + title + '</p>');
			$(".id_mt").val(c);

			$('.inp_edit_' + c).html('<input ' +
				'type="radio" ' +
				'checked="checked" ' +
				'onclick="$.adm.inp_edit(' + c + ', \'' + title + '\')" ' +
				'value="' + c+ '" ' +
				'class="inp_edit" ' +
				'/>');
		},

		elementsLoad: function elementsLoad () {
			$('input[type="radio"]').on('ifChanged', function(event) {
				var id = event['target']['id'];
				var title = event['target']['title'];

				$.adm.inp_edit(id, title)
			});

			$('input[name="id_m"]').on('click', function(event) {
				var id = event['target']['id'];
				var title = event['target']['title'];
				var val = event['target']['val'];

				$('input[type="radio"]').removeAttr('checked');

				$(":radio[name=inp_edit]:checked").each(function() {

					// on future checkbox select to mass edit
					$.adm.conf.set('checked_set', val);
				});

				$.adm.inp_edit(id, title)
			});
		},

		rowDelete: function rowDelete(id, t, n) { console.log('khh', id, t, n)
			$('#modalDel').modal('show');
			$('.delbMod').attr('onclick','$.adm.rowDeleteOk('+ id +', '+ t +', \''+ n +'\')');

			$(".modal-body-mess").html('Вы уверены?');
			$(".modal-title-mess").html('Удалить');
		},

		rowDeleteOk: function rowDeleteOk(id, t, n) {
			var dataString = 'id=' + id + '&table=' + t + '&name=' + n;

			$.ajax({
				cache: false,
				url: '/admin/_tools/rowDelete',
				data: dataString,
				type: 'post',
				dataType: 'JSON',
				success: function(data) {
					if(data['result'] == 'ok') {
						if(data['mess'] == '' || data['mess'] == 'ok') {
							$('#modalDel').modal('hide');
							$('.flt-'+id).parent('div').parent('td').parent('tr').remove();
							$.adm.close_mt();
						}
					}
					if(data['mess'] != '' && data['mess'] != undefined) {
						$(".modal-body-mess").html(data['mess']);
						if(data['title'] != '') {
							$(".modal-title-mess").html(data['title']);
						}
					}
				}
			});
		},

		htmlQuotes: function htmlQuotes(str) {

			str = str.split('\'').join("&quot");
			str = str.split('\"').join("&quot");
			str = str.split('<').join("&lt");
			str = str.split('>').join("&gt");

			return str;
		}
	}
})(jQuery);