const express = require('express');
const router = express.Router();
const productController = require('../controller/productController');

router.post('/api/add_product', productController.addProduct);
router.get('/api/get_All_Products', productController.getProducts);
// router.get('/api/sort/:category', productController.category);

router.put('/api/add_Review/:product_id', productController.addReview);

router.delete(
  '/api/deleteProduct/:product_id',
  productController.deleteProduct
);

module.exports = router;
