import _ from 'lodash'

export default (req, res, next) => {
	req.storeObj = req.storeObj || {};

	// create store
	function _store() {
		this.storeObj = req.storeObj || {};
	}

	// Gets the value at path of object
	_store.prototype.getState = (path, callback) => _.isFunction(callback)
		? callback(_.get(req.storeObj, path))
		: _.get(req.storeObj, path);

	// This method is like _.set except that it accepts customizer which is invoked to produce the objects of path.
	_store.prototype.setState = (path, node, callback) => {
		_.setWith(req.storeObj, path, node);
		_.isFunction(callback) ? callback(node) : null;
	}
	req.store = new _store();
	next();
};
