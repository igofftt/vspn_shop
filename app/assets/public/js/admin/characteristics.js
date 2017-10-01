var
	cHarC = {

		/**
		 * render characteristics
		 * @param d0
		 * @param val
		 * @private
		 */
		_render: function(d0, val) {
			let t = '';
			val = _.isObject(val) ? val : {};

			t += `<div class="form-group row form-obj" id="${d0.name}-d">
            <label for="example-text-input" class="col-2 col-form-label">${d0.name_p}, ${d0.measure}</label>
            <!--<button class="closes btn btn-danger btn-sm"><i class="fa fa-close"></i></button>-->
            <div class="col-10"><div class="row">`;

			for(let ii = 0; d0.value.length > ii; ii++) {
				let d = d0.value[ii];

				if(d.type === 'input') {
					t += `<div class="col-${d.col}">
					<input value="${val[d.name] || ''}" class="form-control" name="pl[params][${d0.name}][${d.name}]" 
					type="text" placeholder="${d.name_p}"></div>`;
				}

				if(d.type === 'color') {
					t += `<div class="col-${d.col}">
          <input class="form-control" value="${val[d.name] || ''}" type="color" id="example-color-input"
           name="pl[params][${d0.name}][${d.name}]" type="text" placeholder="${d.name_p}"></div>`;
				}
			}

			t += `</div>
            </div>
            </div>`;

			$('.cha-s .cont').append(t);
		},

		/**
		 * init
		 */
		initChas: function() {
			this.eventSelect.val(_.map(this.conf.get('body'),
				function(v, k) { cHarC._render(_.find(cHarC.objCh, {name: k}), v); return k; })).trigger('change');
		},

		initialize: function(data) {
			this.conf = new Map(data.params);
			this.eventSelect = $(this.conf.get('selector'));
			cHarC.loadCharacteristics(cHarC.loadOnclick);
		},

		/**
		 * Function load Characteristics
		 * @param callback
		 */
		loadCharacteristics: function(callback) {
			$.ajax({
				cache   : false,
				dataType: 'json',

				success: function(data) {
					let arr = [];

					for(let i = 0; data.length > i; i++)
						arr.push({
							cat: _.isNaN(parseInt(data[i].cat_multi))
								? JSON.parse(data[i].cat_multi)
								: parseInt(data[i].cat_multi),

							measure: data[i].measure || '',
							name   : data[i].system_name || '',
							name_d : data[i].name_description || '',
							name_p : data[i].name || '',
							value  : JSON.parse(data[i].value),
						});

					cHarC.objCh = arr;
					cHarC.renderOptions(cHarC.objCh);
					cHarC.initChas(cHarC.objCh);

					setTimeout(function() {
						if(_.isFunction(callback))
							callback();
					}, 500)
				},

				type: 'post',
				url : '/admin/_tools/get-characteristics/',
			});
		},

		loadOnclick: function() {
			Array.prototype.find = function(value) {
				for(var i = 0; i < this.length; i++)
					if(this[i] == value)
						return i;

				return -1;
			}

			cHarC.eventSelect.on('select2:unselect', function(e) {
				$('#' + e.params.data.id + '-d').remove()
			});

			cHarC.eventSelect.on('select2:select', function(e) {
				cHarC._render(_.find(cHarC.objCh, {name: e.params.data.id}))
			});

			// select characteristics by cat
			$('[name="pl[cat]"]').on('select2:select', function(e) {
				if(_.isEmpty(cHarC.conf.get('body'))) {
					$('.cha-s .cont').html('');

					cHarC.eventSelect.val(_.map(cHarC.objCh, function(o) {
						if((_.isArray(o.cat) ? o.cat : [_.isNull(o.cat) ? '' : o.cat.toString()]).find(e.params.data.id) !== -1) {
							cHarC._render(o);
							return o.name;
						}
					})).trigger('change');
				}
			});
		},

		/**
		 * render select
		 * @param obj
		 */
		renderOptions: function(obj) {
			let n = '';

			for(let i = 0; obj.length > i; i++) {
				let d0 =obj[i];
				n += `<option value="${d0.name}">${d0.name_p}</option>`;
			}

			this.eventSelect.html(n).select2({width: '100%'});
		},
	};
