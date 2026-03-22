const pool = require('../config/db');
const { encryptPassword, decryptPassword, generateToken } = require('../common/Helpers/helpers');

exports.register = async (userData) => {

  const { first_name, last_name, student_number, email, password, residence_id } = userData;
  
  const hashedPassword = encryptPassword(password);

  const [result] = await pool.query(
    'INSERT INTO users (first_name, last_name, student_number, email, password, residence_id) VALUES (?, ?, ?, ?, ?, ?)',
    [first_name, last_name, student_number, email, hashedPassword, residence_id]
  );

  return { id: result.insertId, email };
};

exports.login = async (email, password) => {
  const [rows] = await pool.query(
    'SELECT * FROM users WHERE email = ?',
    [email]
  );

  if (rows.length === 0) {
    throw new Error('User not found');
  }

  const user = rows[0];

  const isMatch = decryptPassword(password, user.password);

  if (!isMatch) {
    throw new Error('Invalid credentials');
  }

  const token = generateToken(user.id, user.email)
  return { token };
};