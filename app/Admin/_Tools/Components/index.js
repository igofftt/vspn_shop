import models from 'app/Admin/models';

const

	/**
	 * Function get Characteristics
	 * @param req
	 * @param res
	 */
	getCharacteristics = (req, res) => models.characteristicsModel
		.findAll({raw: true, where: {active: 1}})
		.then(objFiles => res.json(objFiles)),

	/**
	 * function for query by id and table name
	 * @param req
	 * @param res
	 * @returns {*}
	 */
	showLoaderBrand = (req, res) => {
		let
			body = req.body.body,
			idAlbum = req.body.id_album,
			nameTable = req.body.name_table;

		return models.filesModel
			.findAll({raw: true, where: {active: 1, id_album: idAlbum, name_table: nameTable}})

			.then(objFiles => res.render('admin/Components/characteristics', {
				body      : body,
				files     : objFiles,
				id_album  : idAlbum,
				lang      : req.body.lang,
				name_table: nameTable,
				timestamp : Date.now(),
			}));
	},

	/**
	 * Loader Characteristics
	 * @param req
	 * @param res
	 * @returns {Promise<any> | Promise.<TResult>}
	 */
	showLoaderCharacteristics = (req, res) => {
		let
			body = req.body.body,
			idAlbum = req.body.id_album,
			nameTable = req.body.name_table;

		return models.filesModel
			.findAll({raw: true, where: {active: 1, id_album: idAlbum, name_table: nameTable}})

			.then(objFiles => res.render('admin/Components/characteristics', {
				body      : body,
				files     : objFiles,
				//hex       : hex(Date.now().toString()),
				id_album  : idAlbum,
				lang      : req.body.lang,
				name_table: nameTable,
				timestamp : Date.now(),
			}));
	};

export default {getCharacteristics, showLoaderBrand, showLoaderCharacteristics};
