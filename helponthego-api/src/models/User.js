const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
	name: {
		type: String,
		required: true,
	},
	email: {
		type: String,
		required: true,
		unique: true,
	},
	password: {
		type: String,
		required: true,
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

UserSchema.index({ location: '2dsphere' });

module.exports = mongoose.model('user', UserSchema);
