const authService = require('../services/authService');

exports.register = async (req, res) => {

  try {

    const user = await authService.register(req.body);
    res.status(201).json(user);

  } catch (err) {

    res.status(400).json({ message: err.message });
  }
};

exports.login = async (req, res) => {

  try {

    const { email, password } = req.body;
    const data = await authService.login(email, password);
    res.json(data);

  } catch (err) {

    res.status(401).json({ message: err.message });
  }
};