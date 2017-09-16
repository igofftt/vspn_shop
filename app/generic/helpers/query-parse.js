// parse url
export default req => {
	let query = {};
	let _queryT = [];
	let _query = (req.url || '').split('?')[1];
	_query = (_query || '').toString().split('&');

	for(let i = 0; _query.length >= i; i++) {
		_queryT = _query[i];
		_queryT = (_queryT || '').toString().split('=');
		_queryT[0] && (query[_queryT[0]] = _queryT[1]);
	}

	return query;
}
