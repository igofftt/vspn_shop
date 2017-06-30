// parse url
export default req => {
	let query = {};
	let _query = (req.url || '').split('?')[1];
	_query = (_query || '').toString().split('&');

	for(let i = 0; _query.length >= i; i++) {
		_query = (_query || '').toString().split('=');
		_query[1] && (query[_query[0]] = _query[1]);
	}

	return query;
}
