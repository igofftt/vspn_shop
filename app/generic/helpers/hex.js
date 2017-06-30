import crypto from 'crypto';
export default (str, type = 'sha1') => crypto.createHash(type).update(str).digest('hex')
