const express = require('express');
require('dotenv').config();

const app = express();

// Middleware
app.use(express.json());

// Routes
const authRoutes = require('./routes/authRoutes');
// const protectedRoutes = require('./routes/protectedRoutes');

app.use('/api/auth', authRoutes);
// app.use('/api', protectedRoutes);

// Default route
app.get('/health', (req, res) => {
  res.send('EkseRoomza API is running...');
});

// Start server
const PORT = process.env.PORT || 3001;

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});