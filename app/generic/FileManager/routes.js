import express from 'express'
import logic from './Logic';

const
	router = express.Router();

router.route('/admin/file_manager/show_loader').post(logic.showLoader);
router.route('/admin/file_manager/get_crop').post(logic.getCrop);
router.route('/admin/file_manager/get_edit').post(logic.getEdit);
router.route('/admin/file_manager/set_edit').post(logic.setEdit);
router.route('/admin/file_manager/set_edit').post(logic.setEdit);
router.route('/admin/file_manager/to_main').post(logic.toMain);
router.route('/admin/file_manager/to_main').post(logic.toMain);
router.route('/admin/file_manager/upload_img').post(logic.uploadImg);
export default router;
