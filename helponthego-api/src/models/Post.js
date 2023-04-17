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
	location: {
		type: String,
		required: true,
	},
	date: {
		type: String,
		default: Date.now,
	},
});

module.exports = mongoose.model('post', PostSchema);
