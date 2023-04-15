const mongoose = require('mongoose');

const PostSchema = new mongoose.Schema({
	user: {
		type: mongoose.Schema.Types.ObjectId,
		ref: 'user',
	},
	motive: {
		type: String,
		required: true,
	},
	text: {
		type: String,
		required: true,
	},
	name: {
		type: String,
	},
	avatar: {
		type: Buffer,
	},
	date: {
		type: Date,
		default: Date.now,
	},
});

module.exports = mongoose.model('post', PostSchema);
