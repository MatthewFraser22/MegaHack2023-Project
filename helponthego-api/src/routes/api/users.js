const express = require('express');
const router = express.Router();
const multer = require('multer');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
require('dotenv').config();
const { check, validationResult } = require('express-validator');
const upload = multer({ storage: multer.memoryStorage() });
const User = require('../../models/User');
const uploadAvatar = require('../../middleware/uploadAvatar');

// @route   POST api/users
// @desc    Register user
// @access  Public
router.post(
	'/',

	[
		uploadAvatar,
		[
			check('name', 'Name is required').not().isEmpty(),
			check('email', 'Please include a valid email').isEmail(),
			check(
				'password',
				'Please enter a password with 6 or more characters'
			).isLength({ min: 6 }),
		],
	],
	async (req, res) => {
		const errors = validationResult(req);
		if (!errors.isEmpty()) {
			return res.status(400).json({ errors: errors.array() });
		}
		console.log(req.body);
		const { name, email, password } = req.body;

		try {
			let user = await User.findOne({ email });

			if (user) {
				return res
					.status(400)
					.json({ errors: [{ msg: 'User already exists' }] });
			}

			const avatar = req.file ? req.file.buffer : null;

			user = new User({
				name,
				email,
				avatar,
				password,
			});

			const salt = await bcrypt.genSalt(10);

			user.password = await bcrypt.hash(password, salt);

			await user.save();
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

			res.json({ user: userWithoutPassword });
		} catch (err) {
			console.error(err.message);
			res.status(500).send('Server error');
		}
	}
);

module.exports = router;
