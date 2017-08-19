import _ from 'lodash';
import {hex, getModule} from 'generic/helpers';
import models from 'app/Admin/models';
import gm from 'gm';
import fs from 'fs';

const

	/**
	 * function to cropping images
	 * @param req
	 * @param res
	 */
	getCrop = (req, res) => models.filesModel
		.findById(req.body.id)
		.then(objFile => res.render('admin/Components/FileManager/cropImage', {file: objFile})),

	/**
	 * function init modal window to edit
	 * @param req
	 * @param res
	 */
	getEdit = (req, res) => {
		let
			lang = false,
			nameTable = req.body.name_table;

		console.log('lk', nameTable)


		try {
			lang = JSON.parse(req.body.lang);
		} catch(err) {
			// обработка ошибки
		}

		return models.filesModel
			.findById(req.body.id)
			.then(objFile => res.render('admin/Components/FileManager/getEdit', {
				file      : objFile,
				lang      : lang,
				name_table: nameTable,
			}))},

	/**
	 * save edit info img
	 * @param req
	 * @param res
	 */
	setEdit = (req, res) => {
		let fileId = req.body.id;

		if(fileId)
			return models.filesModel
				.update({
					name : req.body.name,
					order: req.body.order,
					sort : req.body.sort || 0,
					text : req.body.text,
				}, {where: {id: fileId}}).then(() => res.send({result: 'ok'}));
		else
			return res.send('error data');
	},

	/**
	 * function for show album in details
	 * @param req
	 * @param res
	 * @returns {*}
	 */
	showLoader = (req, res) => {
		let
			idAlbum = req.body.id_album,
			nameTable = req.body.name_table;

		return models.filesModel
			.findAll({raw: true, where: {active: 1, id_album: idAlbum, name_table: nameTable}})

			.then(objFiles => res.render('admin/Components/FileManager/showLoader', {
				files     : objFiles,
				hex       : hex(Date.now().toString()),
				id_album  : idAlbum,
				lang      : req.body.lang,
				name_table: nameTable,
				timestamp : Date.now(),
			}));
	},

	/**
	 * Function for assigning an album cover
	 * @param req
	 * @param res
	 */
	toMain = (req, res) => {
		let fileId = req.body.id;

		if(fileId)
			return models.filesModel
				.findById(fileId).then(objFile => {
					return models.filesModel
						.update({main: 0}, {where: {id_album: objFile.id_album, name_table: objFile.name_table}})
						.then(() => models.filesModel
							.update({main: 1}, {where: {id: fileId}}).then(() => res.send({result: 'ok'})),
						)},
				);
		else
			return res.send('error data');
	},

	/**
	 * Function for upload img
	 * @param req
	 * @param res
	 */
	uploadImg = (req, res) => {
		let
			idAlbum = req.body.id_album,
			nameTable = req.body.name_table;

		const resultSend = () => res.send({id: idAlbum, main: 0, name: nameHexExt});
		let file = _.get(req, 'files.Filedata');
		let nameHex = hex(Date.now().toString());
		let ext = file.name.split('.');
		ext = ext[ext.length - 1];
		let nameHexExt = `${nameHex}.${ext}`;

		// check file
		if(file) {
			let pathOriginal = `./app/assets/public/images/files/original/${nameHexExt}`;
			let pathSmall = `./app/assets/public/images/files/small/${nameHexExt}`;
			let pathBig = `./app/assets/public/images/files/big/${nameHexExt}`;
			let pathOriginalApp = `${process.env.PWD}/app/assets/public/images/files/original/${nameHexExt}`;
			let pathSmallApp = `${process.env.PWD}/app/assets/public/images/files/small/${nameHexExt}`;
			let pathBigApp = `${process.env.PWD}/app/assets/public/images/files/big/${nameHexExt}`;

			const
				queryFiles = () =>gm(pathOriginal).filesize((err, filesize) => {
					let obj = {
						active    : 1,
						file      : nameHexExt,
						id_album  : idAlbum,
						main      : 0,
						name_table: nameTable,
						orig_name : file.name,
						size      : filesize,
						type      : ext,
					};

					// Original
					fs.createReadStream(pathOriginal).pipe(fs.createWriteStream(pathOriginalApp));

					// Small
					fs.createReadStream(pathSmall).pipe(fs.createWriteStream(pathSmallApp));

					// Big
					fs.createReadStream(pathBig).pipe(fs.createWriteStream(pathBigApp));

					// TODO добавить проверку на to_main
					return models.filesModel
						.create(obj, {where: {id: idAlbum}}).then(() => resultSend())
				});

			const
				cropResizeSmall = module => {
					// crop & resize to small
					gm(pathOriginal).size((err, size) => {
						let width = _.get(module, 'small_width', 445), widthCrop = _.get(module, 'small_width', 445);
						let height = _.get(module, 'small_height', 255), heightCrop = _.get(module, 'small_height', 255);
						if(size.width < size.height) width = null; else height = null;

						gm(pathOriginal)
							.resize(width, height)
							.crop(widthCrop, heightCrop, null, null)
							.noProfile()

							// save
							.write(pathSmall, e => {
								if(e)
									return console.log(e);

								return queryFiles();
							});
					})
				};

			const
				cropResizeBig = module => {
					// crop & resize to big
					gm(pathOriginal).size((err, size) => {
						let width = _.get(module, 'big_width', 1000), widthCrop = _.get(module, 'big_width', 1000);
						let height = _.get(module, 'big_height', 800), heightCrop = _.get(module, 'big_height', 800);
						if(size.width < size.height) width = null; else height = null;

						gm(pathOriginal)
							.resize(width, height)
							.crop(widthCrop, heightCrop, null, null)
							.noProfile()

							// save
							.write(pathBig, e => {
								if(e)
									return console.log('done');

								return cropResizeSmall(module);
							});
					})
				};

			// save original
			file.mv(pathOriginal, errBild => {
				if(errBild)
					return res.status(500).send(errBild);

				return getModule({name: nameTable, req, res, userId: req.user.id}, module => cropResizeBig(module[0]));
			});
		}

		return null;
	};

export default {getCrop, getEdit, setEdit, showLoader, toMain, uploadImg};
