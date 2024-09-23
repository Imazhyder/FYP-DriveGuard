const express = require('express');
const router = express.Router();
const FavController = require('../controller/FavProductController');

router.post('/api/addToFav', FavController.addToFav);
router.get('/api/getFavData:user_id', FavController.getFavData);

module.exports = router;
