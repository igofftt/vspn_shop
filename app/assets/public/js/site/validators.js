

/**
 * author igofftt https://vk.com/igorian__ru
 */
// неймспейс валидаторов
/* global Constants, grecaptcha */
/* eslint no-undef: "error" */

var
	Validators;

(function() {
	/**
	 * универсальный валидатор поля alpha
	 */
	Validators.Field = (function() {
		// конструктор
		function Field(params) {
			var _params;

			this._params_dafault = {
				_iValid       : -1,
				_oldValue     : null,
				blurOn        : true,
				check_validate: 'required', // переменная для выбора проверок валидатора
				cInvalid      : Constants.cls.INVALID, // класс НЕ правильного заполненного поля
				cValid        : Constants.cls.VALID, // класс правильного заполненного поля
				element       : null, // элемент input
				isValid       : false, // переменная для валидности
				key_13        : null, // enter callback
				keyup_timeout : Constants.numeric.KEYUP_SET_TIMEOUT,
				keyupOn       : true, // валдировать по набору текста
				message       : '', // переменная для ошибки
				nameField     : '', // имя поля
				only_error    : false, // показывать только ошибки
				simple        : false, // показывать сообщения о ошибках
				timer_keyup_id: null, // id для setTimeout
				timer_valid_id: null, // id для setTimeout
				type_validate : 'input', // тип валидатора(пока только один тип, параметр не используется)
				valHint       : Constants.pds.FORM_HINT, // окно hint
				valMsg        : Constants.pds.ERR_FORM_REG, // постфикс для спанов с пояснением ошибки
				xhr           : new XMLHttpRequest(),
			};

			// мержим параметры
			_params = Object.assign(this._params_dafault, params);

			// добавляем параметры в this
			Object.keys(_params).map(function(k) {
				this[k] = _params[k];
			}.bind(this));

			// сохраняем порвоначальное значение инпута
			if(this.element)
				this.valueSave = this.element.value;

			// обработчики событий
			if(this.blurOn && this.element) {
				this.blur = this.cbBlur.bind(this);
				this.element.addEventListener('blur', this.blur);
			}

			if(this.keyupOn && this.element) {
				this.keyup = this.keyUpTimeout(function() {
					this.cbBlur();
				}.bind(this));

				this.element.addEventListener('keyup', this.keyup);
			}

			if(this.key_13) {
				this.element.addEventListener('keyup', function(e) {
					var key = e.which || e.keyCode;

					if(key === 13) {
						this.key_13();
					}
				}.bind(this));
			}
		}

		/**
		 * проверка валидности
		 * @returns {boolean}
		 */
		Field.prototype.valid = function() {
			// если пользователь попытается сохранить изменения до того как проверка валидации закончилась,
			// то ему вернётся false, но если валидация в момент нажатия неавтивна то вернётся реальный флаг
			if(this._iValid === -1) {
				return !this.isValid;
			}
			else {
				return false;
			}
		};

		/**
		 * метод обновления окна Hint
		 */
		Field.prototype.hintShow = function() {
			var spHint = document.getElementById(this.element.id + this.valHint);

			if(spHint)
				if(this.hint)
					spHint.classList.add('active');
				else
					spHint.classList.remove('active');
		};

		/**
		 * метод обновления css инпута
		 */
		Field.prototype.cssUpdate = function() {
			var spValMsg = document.getElementById(this.element.id + this.valMsg);

			if(!this.isValid) {
				this.element.classList.remove(this.cInvalid);

				if(!this.only_error) {
					this.element.classList.add(this.cValid);
				}

				if(!this.simple && spValMsg) {
					spValMsg.innerHTML = this.message;
				}
			}
			else {
				this.element.classList.remove(this.cValid);
				this.element.classList.add(this.cInvalid);

				if(!this.simple && spValMsg) {
					spValMsg.innerHTML = this.message;
				}
			}
		};

		/**
		 * колбэк обработчика потери фокуса
		 */
		Field.prototype.cbBlur = function() {
			clearTimeout(this.timer_valid_id);
			this.validate();
		};

		/**
		 * функция вызова валидации
		 */
		Field.prototype.validate = function() {
			clearTimeout(this.timer_valid_id);

			// убиваем лишнюю проверку, когда значение не меняется
			if(this._oldValue !== this.element.value) {
				// обновляем старое значение текущим
				this._oldValue = this.element.value;
				this._validate();
			}
		};

		/**
		 * имитация очереди посредством колбеков, в валидаторах обязательно должен
		 * быть колбэк для созранения цепочки проверки
		 */
		Field.prototype._validate = function() {
			this.timer_valid_id = setTimeout(function() {
				// валидация по заданным параметрам
				var arrValidate = this.check_validate.split('|');
				this._iValid++;

				if(!this._iValid && this.isValid) {
					// сброс для нового прохода валидации
					this.isValid = false;
				}

				// если поле не валидное, то выходим либо проход завершён
				if(typeof arrValidate[this._iValid] !== 'string' || this.isValid) {
					this._iValid = -1;

					if(!this.simple) {
						this.cssUpdate();
					}
				}
				else {
					this[arrValidate[this._iValid].split('_')[0]](arrValidate[this._iValid].split('_')[1] || null);
				}
			}.bind(this), 0);
		};

		/**
		 * сброс формы валидации к изначальному виду (css)
		 */
		Field.prototype.cssReset = function(clear) {
			var spValMsg = document.getElementById(this.element.id + this.valMsg);
			this.xhr.abort();
			clearTimeout(this.timer_keyup_id);
			this._oldValue = null;

			setTimeout(function() {
				this.element.classList.remove(this.cValid, this.cInvalid);

				if(clear) {
					this.element.value = '';
				}

				if(!this.simple && spValMsg) {
					spValMsg.innerHTML = '';
				}
			}.bind(this), 0);
		};

		/**
		 * callback setTimeout
		 * @param callback
		 * @returns {function(this:this.Field)}
		 */
		Field.prototype.keyUpTimeout = function(callback) {
			return function() {
				clearTimeout(this.timer_keyup_id);

				this.timer_keyup_id = setTimeout(function() {
					if(typeof callback !== 'function') {
						return null;
					}

					return callback();
				}, this.keyup_timeout);
			}.bind(this);
		};

		/* start метода проверок start */
		// проверка на пустоту
		Field.prototype.required = function() {
			this.isValid = false;
			this.message = '';

			if(!this.element.value.trim()) {
				this.isValid = true;
				this.message = Constants.captions.REQUIRED_FIELD.replace('%%', this.nameField);
			}

			this._validate();
		};

		// проверка только текст
		Field.prototype.onlyText = function() {
			this.isValid = false;
			this.message = '';

			if(!Constants.regex.REGEX_ONLY_TEXT.test(this.element.value)) {
				this.isValid = true;
				this.message = Constants.captions.ONLY_TEXT.replace('%%', this.nameField);
			}

			this._validate();
		};

		// проверка на маленькую строку
		Field.prototype.min = function(n) {
			this.isValid = false;

			if(this.element.value.length < n) {
				this.isValid = true;
			}

			this._validate();
		};

		// проверка на большую строку
		Field.prototype.max = function(n) {
			this.isValid = false;

			if(this.element.value.length > n) {
				this.isValid = true;
			}

			this._validate();
		};

		// проверка на мобильный номер телефона
		Field.prototype.phoneMobile = function() {
			this.isValid = false;
			this.message = '';

			if(!Constants.regex.REGEX_CORRECT_MOBILE_PHONE.test(this.element.value)) {
				this.isValid = true;
				this.message = Constants.captions.INCORRECT_FIELD_PHONE;
			}

			this._validate();
		};

		// проверка корректности Email
		Field.prototype.email = function() {
			this.isValid = false;
			this.message = '';

			if(!Constants.regex.REGEX_CORRECT_EMAIL.test(this.element.value)) {
				this.isValid = true;
				this.message = Constants.captions.INCORRECT_FIELD_EMAIL;
			}

			this._validate();
		};

		// k == 0 - уникльный адрс. k == 1 проверка на существование адрса в базе
		// проверка на правильный email адрес
		Field.prototype.emailUnique = function(k) {
			var
				_k = k || '0',
				formData,
				xhr;

			// отправляем запрос
			xhr = this.xhr;
			xhr.open('POST', '/account/isemailuniq', true);
			xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');

			formData = JSON.stringify({email: this.element.value});
			xhr.send(formData);

			// this.prototype.xhr = xhr.abort;
			xhr.onreadystatechange = function() {
				var r, resConst;

				// данные еще не получены, выходим
				if(xhr.readyState !== 4) {
					return;
				}

				// данные получены, код ответа 200
				if(xhr.status === 200) {
					try {
						r = JSON.parse(xhr.responseText);
					}
					catch(e) {
						r = {error: e, result: 3};
					}

					if(_k === '0') {
						if(r.result !== 0) {
							if(this.element.value === this.valueSave) {
								this.isValid = false;
								this.message = '';
							}
							else {
								// определяем ошибку
								resConst = Constants.AjaxAnswersDescrs[r.result];
								this.isValid = true;
								this.message = resConst.captions;
							}
						}
					}
					else {
						if(_k === '1' && r.result !== 3) {
							this.isValid = true;
							this.message = Constants.captions.EMAIL_NOT_FOUND;
						}
						else {
							this.isValid = false;
							this.message = '';
						}
					}

					this._validate();
				}
			}.bind(this);
		};

		// проверка корректности пароля
		Field.prototype.password = function() {
			this.isValid = false;
			this.message = '';
			this.hint = false;

			if(!Constants.regex.REGEX_CORRECT_PASSWORD.test(this.element.value)) {
				this.hint = true;
				this.isValid = true;
				this.message = Constants.captions.INCORRECT_FIELD_PASSWORD;
			}

			this.hintShow();
			this._validate();
		};

		// проверка корректности пароля
		Field.prototype.passwordCyrillic = function(k) {
			this.isValid = false;
			this.message = '';
			this.hint = false;

			if(k != Constants.regex.REGEX_CORRECT_PASSWORD_CYR.test(this.element.value)) {
				this.hint = true;
				this.isValid = true;
				this.message = Constants.captions.INCORRECT_FIELD_PASSWORD;
			}

			this.hintShow();
			this._validate();
		};

		// проверка текущего пароля
		Field.prototype.passwordCurrent = function() {
			let formData, xhr;
			this.isValid = false;
			this.message = '';

			// отправляем запрос
			xhr = this.xhr;
			xhr.open('POST', '/account/passwordcheck', true);
			xhr.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
			formData = JSON.stringify({password: this.element.value});
			xhr.send(formData);

			// this.prototype.xhr = xhr.abort;
			xhr.onreadystatechange = function() {
				let r, resConst;

				// данные еще не получены, выходим
				if(xhr.readyState !== 4) {
					return;
				}

				// данные получены, код ответа 200
				if(xhr.status === 200) {
					try {
						r = JSON.parse(xhr.responseText);
					}
					catch(e) {
						r = {error: e, result: 3};
					}

					if(r.result !== 0) { // определяем ошибку
						resConst = Constants.AjaxAnswersDescrs[r.result];
						this.isValid = true;
						this.message = resConst.captions;
					}

					this._validate();
				}
			}.bind(this);
		};

		// сравнение значение двух полей
		Field.prototype.compare = function() {
			this.isValid = false;
			this.message = '';

			if(this.element.value !== this.compare_element.value) {
				this.isValid = true;

				// TODO заменить на replace тип ошибок
				this.message = Constants.captions.INCORRECT_FIELD_REPASSWORD;
			}

			this._validate();
		};

		// сравнение значение двух полей
		Field.prototype.captchaGoogle = function() {
			this.isValid = false;
			this.message = '';
			this.hint = false;
			this.response = grecaptcha.getResponse();
			this.element.value = this.response ? 'ok' : 'error';

			if(!this.response) {
				this.hint = true;
				this.isValid = true;
			}

			this.hintShow();
			this._validate();
		};

		return Field;
	}());
}(Validators || (Validators = {})));
