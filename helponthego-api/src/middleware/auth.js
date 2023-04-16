const jwt = require('jsonwebtoken');
require('dotenv').config();

module.exports = function (req, res, next) {
	const user = req.header('user_id');

	if (!user) {
		return res.status(401).json({ msg: 'No user id' });
	}

	try {
		req.user_id = user;
		next();
	} catch (err) {
		res.status(401).json({ msg: 'Token is not valid' });
	}
};
