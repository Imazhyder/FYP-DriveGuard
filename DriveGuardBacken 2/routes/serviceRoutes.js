const express = require('express');
const router = express.Router();
const servicsController = require('../controller/ServiceController');

router.post('/api/create-service', servicsController.addService);
router.get('/api/get-all-services', servicsController.getServices);

router.post('/api/book-service', servicsController.bookSerivce);

router.delete(
  '/api/deleteService/:service_id',
  servicsController.deleteService
);

module.exports = router;
