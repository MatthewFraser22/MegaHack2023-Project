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
	location: {
		type: { type: String, enum: ['Point'], required: true },
		coordinates: {
			type: [Number],
			required: true,
		},
	},
	date: {
		type: Date,
		default: Date.now,
	},
});

PostSchema.index({ location: '2dsphere' });
module.exports = mongoose.model('post', PostSchema);
