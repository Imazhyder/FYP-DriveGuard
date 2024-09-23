const express = require('express');
const router = express.Router();
const OrderController = require('../controller/orderController');

router.post('/api/create-order', OrderController.addOrder);
router.get('/api/getOrders/:user_id', OrderController.getOrders);
router.get('/api/getAllOrders', OrderController.getAllOrders);
router.put('/api/changeOrderStatus', OrderController.changeOrderStatus);

module.exports = router;
