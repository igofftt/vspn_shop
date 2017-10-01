import _ from 'lodash';
import {getCat, getProductsOfSessions} from 'generic/helpers';
import models from 'app/Admin/models';
import sendmail from 'sendmail';

const

	/**
	 * Page Cart
	 * @param req
	 * @param res
	 */
	index = (req, res) => {
		const
			renderPage = () => res.render('site/Cart/indexCart', {
				error        : req.flash('error').toString(),
				menuTop      : req.store.getState('site.menuTop'),
				meta         : {title: 'VSPN'},
				parent_module: 'indexPage',
				this_module  : 'indexPage',
				user         : req.user,
			}),

			getMenuTop = callback => getCat({lang: 'ru', req, res, type: 'array'}, tree =>
				req.store.setState('site.menuTop', tree, callback));

		return getMenuTop(renderPage);
	},

	/**
	 * Send & save ordering
	 * @param req
	 * @param res
	 */
	sendOrdering = (req, res) => {
		const
			sendMail = () => sendmail({
				from   : 'no-reply@duzer.ru',
				html   : 'Mail of test sendmail ',
				subject: 'test sendmail',
				to     : 'igorian.ru@mail.ru',
			},(err, reply) => {
				console.log(err && err.stack);
				console.dir(reply);
			}),

			createOrdering = applications => {
				let
					cart = req.session.cart,
					products = req.store.getState('site.products.data'),
					quantity;

				// Delete the trash
				_.setWith(req.session, 'cart', {});

				_.map(products, v => {
					quantity = parseInt(_.get(cart, `${v.id}.quantity`));

					models
						.ordersModel

						.create({
							count           : quantity,
							created_at      : Date.now(),
							current_discount: v.discount || 0,
							current_price   : v.price || 0,
							id_applications : applications.id,
							id_parent       : v.id,
							id_user         : 0,
							sum_price       : (quantity * v.price),
						})
						.then(() => {});
				})
			},

			createFirstStatus = applications => {
				models
					.statusesModel

					.create({
						active    : 1,
						created_at: Date.now(),
						id_user   : 0,
						parent_id : applications.id,
						status    : 0,
					})

					.then(() => {});
			},

			createApplications = () => {
				models
					.applicationsModel

					.create({
						active     : 1,
						apartment  : req.body.apartment,
						cite       : req.body.cite,
						comment    : req.body.comment,
						created_at : Date.now(),
						email      : req.body.email,
						home       : req.body.home,
						name_person: req.body.name,
						phone      : req.body.phone,
						street     : req.body.street,
						surname    : req.body.surname,
					})

					.then(result => {
						createFirstStatus(result);
						createOrdering(result);
						sendMail();
						res.json({result: 'ok'});
					});
			};

		return getProductsOfSessions(req, res, () => createApplications);
	};

export default {index, sendOrdering}
