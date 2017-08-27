/**
 * Константы и тексты
 */
var Constants;
(function () {
  'use strict';

  /**
   * функция добавления константы в объект
   * @param c функция в которую добавляем константу
   * @param n ключ
   * @param t значение
   * @param m тип ключа.array|object по умолчанию(пустота) === object
   * @returns {Object}
   */
  function setKey(c, n, t, m) {
    if(m === 'array') {
      return c.splice(n, 0, t);
    } else {
      return Object.defineProperty(c, n, {
        get: function () { return t; },
        enumerable: true,
        configurable: true
      });
    }
  }

  /**
   * Константы с именами CSS-классов
   */
  Constants.cls = (function () {
    function Cls() {}
    setKey(Cls, 'INVALID', 'invalid'); // класс ошибки заполнения формы
    setKey(Cls, 'VALID', 'valid'); // класс правильного заполненного поля формы

    return Cls;
  }());

  /**
   * Набор стандартизированных идентификаторов
   */
  Constants.ids = (function () {
    function Ids() {}
    setKey(Ids, 'REQUIRED_FIELD_EMAIL', 'Поле e-mail обязательно к заполнению');

    return Ids;
  }());

  /**
   * Постфиксы - дополнения к классам или индетификаторам
   */
  Constants.pds = (function () {
    function Pds() {}
    setKey(Pds, 'ERR_FORM_REG', 'ValMsg');  // постфикс для спанов с пояснением ошибки
    setKey(Pds, 'FORM_HINT', 'Hint');  // окно hint

    return Pds;
  }());

  /**
   * Регексы
   */
  Constants.regex = (function () {
    function Regex() {}
    // регикс для проверки пароля
    setKey(Regex, 'REGEX_CORRECT_PASSWORD', /(?=.*[0-9])(?=.*[a-z])^[\Wa-z\d_]{6,25}$/i);
    // регикс для проверки пароля на кириллицу
    setKey(Regex, 'REGEX_CORRECT_PASSWORD_CYR', /[аА-яЯ]/i);
    // регикс для проверки E-mail
    setKey(Regex, 'REGEX_CORRECT_EMAIL', /^[\w!#$%&'*+\-/=?\^_`{|}~]+(\.[\w!#$%&'*+\-/=?\^_`{|}~]+)*@((([\-\w]+\.)+[a-zA-Z]{2,5})|(([0-9]{1,3}\.){3}[0-9]{1,3}))$/i);
    // регикс для проверки mobile phone
    setKey(Regex, 'REGEX_CORRECT_MOBILE_PHONE', /^\+[1-9]{1}[0-9]{7,11}$/i);
    // регикс только текст
    setKey(Regex, 'REGEX_ONLY_TEXT', /[aA-zZ-аА-яЯ]$/i);

    return Regex;
  }());

  /**
   * текстовые констаты
   */
  Constants.captions = (function () {
    function Captions() {}
    setKey(Captions, 'REQUIRED_FIELD', 'Поле %% не должно быть пустым');
    setKey(Captions, 'ONLY_TEXT', 'Поле %% должно содержать только текст');
    setKey(Captions, 'INCORRECT_FIELD_EMAIL', 'Введите корректный Email');
    setKey(Captions, 'NOT_AVAILABLE_FIELD_EMAIL', 'Такой Email уже зарегистрирован');
    setKey(Captions, 'REQUIRED_FIELD_PASSWORD', '');
    setKey(Captions, 'SHORT_FIELD_PASSWORD', 'Минимальная длина Пароля 6 символов');
    setKey(Captions, 'LONG_FIELD_PASSWORD', 'Максимальная длина Пароля 25 символов');
    setKey(Captions, 'INCORRECT_FIELD_PASSWORD', 'Пароль должен быть из латинских букв и содержать хоть одну цифру');
    setKey(Captions, 'INCORRECT_FIELD_REPASSWORD', 'Пароли не совпадают');
    setKey(Captions, 'EMAIL_EXIST', 'Указанный адрес почты уже зарегистрирован');
    setKey(Captions, 'EMAIL_NOT_FOUND', 'Указанный адрес почты не зарегистрирован');
    setKey(Captions, 'SERVER_ERROR', 'Ошибка сервера. Повторите попытку через несколько минут.');
    setKey(Captions, 'DATA_INVALID', 'Получены неверные данные');
    setKey(Captions, 'XML2OBJ_ERROR', 'Ошибка разбора XML');
    setKey(Captions, 'INCORRECT_FIELD_PHONE', 'Неизвестный формат.');

    return Captions;
  }());

  /**
   * числовые констаты
   */
  Constants.numeric = (function () {
    function Captions() {}
    setKey(Captions, 'SHORT_FIELD_PASSWORD', 6); // минимальная длина пароля
    setKey(Captions, 'LONG_FIELD_PASSWORD', 25); // максимальная длина пароля
    setKey(Captions, 'KEYUP_SET_TIMEOUT', 500); // время задержки вызова валидации по keyup

    return Captions;
  }());

  /**
   * коды ответов
   */
  Constants.AjaxAnswersDescrs = (function () {
    var Codeerror = [];
    setKey(Codeerror, 0, {result: true, captions: ''}, 'array');
    setKey(Codeerror, 1, {result: false, captions: Constants.captions.SERVER_ERROR}, 'array');
    setKey(Codeerror, 2, {result: false, captions: Constants.captions.DATA_INVALID}, 'array');
    setKey(Codeerror, 3, {result: false, captions: Constants.captions.EMAIL_EXIST}, 'array'); // пришёл некорректный json ответ
    setKey(Codeerror, 4, {result: false, captions: Constants.captions.EMAIL_NOT_FOUND}, 'array');
    setKey(Codeerror, 5, {result: false, captions: Constants.captions.XML2OBJ_ERROR}, 'array');

    return Codeerror;
  }());

  Constants.AjaxAnswers = {
    /* eslint-disable sort-keys */
    OK:                               0,
    SERVER_ERROR:                     1, // ошибка на стороне сервера
    INVALID_INPUT_DATA:               2, // получены неверные данные
    EMAIL_EXIST:                      3, // почта уже зарегистрирована
    AUTH_COOKIE_ERROR:                4, // проблемы с авторизационно кукой
    XML2OBJ_ERROR:                    5, // ошибка парсинга XML в Object
    /* eslint-enable sort-keys */
  };

}(Constants || (Constants = {})));
