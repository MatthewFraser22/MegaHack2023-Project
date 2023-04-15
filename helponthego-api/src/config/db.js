const mongoose = require('mongoose');

require('dotenv').config();

const db = process.env.MongoURI;

const connectDB = async () => {
	try {
		await mongoose.connect(db);
		console.log('MongoDB Connected...');
	} catch (error) {
		console.log(error.message);

		process.exit(1);
	}
};

module.exports = connectDB;
