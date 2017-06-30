import express from 'express'

const
	app = express();

export default () => {
	app.get('/messages/', () => {
		console.log('hhhhhhhhh')
	});

}
