const express = require('express');
const router = express.Router();
const CancelOrderController = require('../controller/CancelOrderController');

router.post('/api/cancelRequest', CancelOrderController.cancelRequest);
router.get('/api/getcancelRequest', CancelOrderController.getCancelRequest);

module.exports = router;
