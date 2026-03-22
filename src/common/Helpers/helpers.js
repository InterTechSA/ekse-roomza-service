// TEST CONNECTION
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');


exports.testDBConnection = async () => {
    try {
        const [rows] = await pool.query('SELECT 1');
        console.log('✅ Database connected successfully');
    } catch (err) {
        console.error('❌ Database connection failed:', err.message);
    }
}

exports.generateToken = async (id, email) => {

    let token = jwt.sign(
        { id, email },
        process.env.JWT_SECRET,
        { expiresIn: process.env.JWT_EXPIRES_IN });

    return token;
}

exports.verifyToken = async (token) => {

    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    return decoded;
}

exports.encryptPassword = async (password) => {

    let encrypted_password = await bcrypt.hash(password, 10)

    return encrypted_password;
}

exports.decryptPassword = async (password, encrypted_password) => {

    const isMatch = await bcrypt.compare(password, encrypted_password);

    return isMatch;
}