const express = require('express');
const router = express.Router();

const carController = require('../../controller/Car/CarController');

router.post('/api/create-car', carController.addCar);
router.get('/api/getAllCars', carController.getAllCars);

module.exports = router;
