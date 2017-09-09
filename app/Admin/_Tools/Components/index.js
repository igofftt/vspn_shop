import models from 'app/Admin/models';

/**
 * function for query by id and table name
 * @param req
 * @param res
 * @returns {*}
 */
const
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

export default {showLoaderCharacteristics};
