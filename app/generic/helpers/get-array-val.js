import _ from 'lodash'
export default (name, obj) => _.map(obj, v => v[name])
