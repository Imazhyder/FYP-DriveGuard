const jwt = require('jsonwebtoken');
const User = require('../model/usermodel');
const bcrypt = require('bcrypt');

exports.verifyToken = (req, res, next) => {
  const token = req.headers.authorization;
  if (!token) {
    return res.status(403).json({ message: 'Token Required' });
  }

  jwt.verify(token.split(' ')[1], 'your-secret-key', (err, decoded) => {
    if (err) {
      return res.status(401).json({ message: 'Invalid token' });
    }
    req.body = decoded; //the decoded value will be saved in req.boy
    console.log(req.body);
    next();
  });
};

exports.getUserData = async (req, res) => {
  console.log('userdata running');
  try {
    const user = await User.findById(req.body.userId).select([
      'username',
      'email',
      'Gender',
      'country',
      'address',
    ]);

    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }
    res.status(200).json(user);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

exports.updateUserInfo = async (req, res) => {
  const { id } = req.params;
  console.log(id);

  try {
    const user = await User.findByIdAndUpdate(id, req.body, {
      runValidators: true,
    });

    console.log(user);

    res.status(200).json({ message: 'User updated' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deleteUser = async (req, res) => {
  const { user_id } = req.params;

  try {
    const deletedUser = await User.findByIdAndDelete(user_id);

    if (!deletedUser) {
      res.status(404).json({ message: 'User not found' });
    }

    res.status(200).json({ message: 'User Deleted Successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.changePassword = async (req, res) => {
  const { user_id } = req.params;
  const { currentPassword, confirmPassword } = req.body;
  try {
    const user = await User.findById(user_id);

    if (!user) {
      return res.json({ message: 'User not Found' });
    }

    const isCurrentPasswordValid = await bcrypt.compare(
      currentPassword,
      user.password
    );

    if (!isCurrentPasswordValid) {
      return res
        .status(400)
        .json({ message: 'Your current Password is not valid' });
    }

    const isSamePassword = await bcrypt.compare(confirmPassword, user.password);

    if (isSamePassword) {
      return res.status(401).json({
        message: 'New password cannot be the same as the current password',
      });
    }

    const hashedconfirmPassword = await bcrypt.hash(confirmPassword, 10);
    user.password = hashedconfirmPassword;

    await user.save();

    return res
      .status(200)
      .json({ message: 'Your password has been changed successfully' });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

exports.getAllUserData = async (req, res) => {
  try {
    const users = await User.find({}, ['username', 'email']);

    if (!users) {
      return res.status(400).json({ message: 'There are not users' });
    }

    res.status(200).json(users);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

exports.checkUser = async (req, res) => {
  const { user_id } = req.params;
  try {
    const user = await User.findById(user_id);

    if (!user) {
      return res.status(400).json({ message: 'No Such User' });
    }

    return res.status(200).json({ message: 'User founded' });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
