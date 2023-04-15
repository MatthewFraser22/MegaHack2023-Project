//adding, fetching, updating profiles
const express = require('express');
const router = express.Router();
const auth = require('../../middleware/auth');
const { check, validationResult } = require('express-validator');
const Profile = require('../../models/Profile');
const User = require('../../models/User');
const uploadAvatar = require('../../middleware/uploadAvatar');

// @route   GET api/profile
// @desc    Get all user profiles
// @access  Public
router.get('/', async (req, res) => {
	try {
		const profiles = await Profile.find().populate('user', ['name', 'avatar']);
		const profilesWithBase64Avatars = profiles.map((profile) => {
			profile = profile.toObject();
			if (profile.user.avatar) {
				profile.user.avatar = `data:image/jpeg;base64,${profile.user.avatar.toString(
					'base64'
				)}`;
			}
			return profile;
		});
		res.json(profilesWithBase64Avatars);
	} catch (err) {
		console.error(err.message);
		res.status(500).send('Server Error');
	}
});

// @route   GET api/profile/me
// @desc    Get logged in user profile
// @access  Private
router.get('/me', auth, async (req, res) => {
	try {
		const profile = await Profile.findOne({ user: req.user.id }).populate(
			'user',
			['name', 'avatar']
		);

		if (!profile) {
			return res.status(400).json({ msg: 'There is no profile for this user' });
		}

		const profileWithBase64Avatar = profile.toObject();
		if (profileWithBase64Avatar.user.avatar) {
			profileWithBase64Avatar.user.avatar = `data:image/jpeg;base64,${profileWithBase64Avatar.user.avatar.toString(
				'base64'
			)}`;
		}

		res.json(profileWithBase64Avatar);
	} catch (err) {
		console.error(err.message);
		res.status(500).send('Server error');
	}
});

// @route   PUT api/profile/avatar
// @desc    Update profile avatar
// @access  Private
router.put('/avatar', [auth, uploadAvatar], async (req, res) => {
	try {
		if (!req.file) {
			return res.status(400).json({ msg: 'No image file uploaded' });
		}

		const buffer = req.file.buffer;

		// Find the user associated with the profile
		const profile = await Profile.findOne({ user: req.user.id });

		if (!profile) {
			return res.status(404).json({ msg: 'profile doesnt exist' });
		}

		// Update the user's avatar
		profile.avatar = buffer;
		await profile.save();

		res.json({ msg: 'Avatar updated successfully' });
	} catch (err) {
		console.error(err.message);
		res.status(500).send('Server error');
	}
});

// @route   POST api/profile
// @desc    create or update user profile
// @access  Private
router.post(
	'/',

	[auth, [check('userType', 'User type(s) is required').not().isEmpty()]],
	async (req, res) => {
		const errors = validationResult(req); //checks for body errors
		if (!errors.isEmpty()) {
			return res.status(400).json({ errors: errors.array() });
		}

		const { bio, completed, location, userType, rating, phone, email } =
			req.body;

		const profileFields = {};
		profileFields.user = req.user.id;

		if (location) profileFields.location = location;
		if (bio) profileFields.bio = bio;
		if (completed) profileFields.completed = completed;
		if (userType) profileFields.userType = userType;
		if (rating) profileFields.rating = rating;
		if (phone) profileFields.phone = phone;
		if (email) profileFields.email = email;

		profileFields.contact = {};
		if (phone) profileFields.contact.phone = phone;
		if (email) profileFields.contact.email = email;

		try {
			let profile = await Profile.findOne({ user: req.user.id }); //look for profile

			if (profile) {
				// if profile exists we just update it
				//update profile
				profile = await Profile.findOneAndUpdate(
					{ user: req.user.id },
					{ $set: profileFields },
					{ new: true }
				); //update profilefields
				return res.json(profile);
			}

			//if profile doesnt exist we need to create one
			profile = new Profile(profileFields);

			await profile.save();
			res.json(profile);
		} catch (err) {
			console.error(err.message);
			res.status(500).send('Server error');
		}
	}
);

// @route   GET api/profile/user/:user_id
// @desc    Get profile from user ID
// @access  Public
router.get('/user/:user_id', async (req, res) => {
	try {
		const profile = await Profile.findOne({
			user: req.params.user_id,
		}).populate('user', ['name', 'avatar']); //find user using user id parameter;populate adds name and avatar field to user in response
		if (!profile) {
			return res.status(400).json({ msg: 'Profile not found' });
		}
		res.json(profile);
	} catch (err) {
		console.error(err.message);
		if (err.kind == 'ObjectId')
			return res.status(401).json({ msg: 'Profile not found' });

		res.status(500).send('Server Error');
	}
});

// @route   PUT api/profile/reviews
// @desc    PUT profile review
// @access  Private

router.put(
	'/:user_id/reviews',
	[auth, [check('rating', 'Rating is required').not().isEmpty()]],
	async (req, res) => {
		const errors = validationResult(req);
		if (!errors.isEmpty()) {
			return res.status(400).json({ errors: errors.array() });
		}

		const { rating, review } = req.body;

		const newReview = {
			rating,
			review,
		};
		try {
			const profile = await Profile.findOne({ user: req.params.user_id });

			profile.reviews.unshift(newReview);

			await profile.save();

			res.json(profile);
		} catch (err) {
			console.error(err.message);
			res.status(500).send('Server error');
		}
	}
);

// @route   DELETE api/profile
// @desc    DELETE profile, user, and post
// @access  Private
router.delete('/', auth, async (req, res) => {
	try {
		await Promise.all([
			Profile.findOneAndRemove({ user: req.user.id }),

			User.findOneAndRemove({ _id: req.user.id }),
		]);

		res.json({ msg: 'User deleted' });
	} catch (err) {
		console.error(err.message);
		res.status(500).send('Server Error');
	}
});

module.exports = router;
