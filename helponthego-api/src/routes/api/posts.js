const express = require('express');
const router = express.Router();
const auth = require('../../middleware/auth');
const { check, validationResult } = require('express-validator');
const Profile = require('../../models/Profile');
const User = require('../../models/User');
const Post = require('../../models/Post');
const { restart } = require('nodemon');

// @route   POST api/posts
// @desc    Create a post
// @access  Private

router.post(
	'/',
	[
		auth,
		[
			check('text', 'Text is required').not().isEmpty(),
			check('location', 'Location is required').not().isEmpty(),
		],
	],
	async (req, res) => {
		const errors = validationResult(req);
		if (!errors.isEmpty()) {
			return res.status(400).json({ errors: errors.array() });
		}

		try {
			const user = await User.findById(req.user_id).select('-password');
			//const profile = await Profile.findOne({ user: req.user_id });

			const newPost = new Post({
				text: req.body.text,
				name: user.name,
				location: req.body.location,
				motive: req.body.motive,
				//avatar: profile.avatar,
				user: req.user_id,
			});

			const post = await newPost.save();

			res.json(post);
		} catch (err) {
			console.error(err.message);
			res.status(500).send('Server error');
		}
	}
);

// @route   Get api/posts
// @desc    Get all posts
// @access  Private ;
router.get('/', async (req, res) => {
	try {
		const posts = await Post.find().sort({ date: -1 });
		res.json(posts);
	} catch (err) {
		console.error(err.message);
		res.status(500).send('Server error');
	}
});

// @route   Get api/posts/:id
// @desc    Get post by id
// @access  Private ;
router.get('/:id', async (req, res) => {
	try {
		const post = await Post.findById(req.params.id);

		if (!post) {
			return res.status(404).json({ msg: 'Post not found' });
		}

		res.json(post);
	} catch (err) {
		console.error(err.message);
		res.status(500).send('Server error');
	}
});

// @route   Delete api/posts
// @desc    Delete a post
// @access  Private ;
router.delete('/:id', auth, async (req, res) => {
	try {
		const post = await Post.findById(req.params.id);

		if (!post) {
			return res.status(404).json({ msg: 'Post not found' });
		}

		if (post.user.toString() != req.user_id) {
			return res.status(401).json({ msg: 'User not authorized' });
		}

		await Post.deleteOne({ _id: req.params.id });

		res.json({ msg: 'Post deleted' });
	} catch (err) {
		console.error(err.message);
		res.status(500).send('Server error');
	}
});

module.exports = router;
