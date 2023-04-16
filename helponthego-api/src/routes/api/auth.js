const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const auth = require('../../middleware/auth');
const { check, validationResult } = require('express-validator');
const User = require('../../models/User');
const jwt = require('jsonwebtoken');
require('dotenv').config();

// @route  Get api/auth
// @desc    Get user by id
// @access  Private
router.get('/', auth, async (req, res) => {
	try {
		const user = await User.findById(req.user_id).select('-password');
		res.json(user);
	} catch (err) {
		console.error(err.message);
		res.status(500).send('Server Error');
	}
});

// @route   Post api/auth
// @desc    Authenticate user and get token; login user
// @access  Public
router.post(
	'/',
	[
		check('email', 'Valid email is required').isEmail(),
		check('password', 'Password is required ').exists(),
	],
	async (req, res) => {
		const errors = validationResult(req);
		if (!errors.isEmpty()) {
			return res.status(400).json({ errors: errors.array() });
		}
		const { email, password } = req.body;
		try {
			let user = await User.findOne({ email });
			if (!user) {
				return res
					.status(400)
					.json({ errors: [{ msg: 'Invalid Credentials' }] });
			}

			const isMatch = await bcrypt.compare(password, user.password);

			if (!isMatch) {
				return res.status(400).json({ msg: 'Invalid Credentials' });
			}

			const payload = {
				user: {
					id: user.id,
				},
			};

			const userWithoutPassword = {
				_id: user._id,
				name: user.name,
				email: user.email,
				date: user.date,
			};
			// Send the token and user object in the response
			res.json({ user: userWithoutPassword });
		} catch (err) {
			console.error(err.message);
			res.status(500).send('Server error');
		}
	}
);

module.exports = router;
