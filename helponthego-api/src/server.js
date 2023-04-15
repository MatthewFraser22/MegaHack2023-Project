const express = require('express');
const connectDB = require('./config/db');
require('dotenv').config();

const app = express();

// Connect Database
connectDB();

//Init middleware
app.use(express.json({ extended: false }));

const PORT = process.env.PORT || 5001;

app.get('/', (req, res) => res.send('API running'));

app.use('/api/users', require('./routes/api/users'));
app.use('/api/auth', require('./routes/api/auth'));

app.listen(PORT, () => console.log(`Server started on port ${PORT}`));
