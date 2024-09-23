const moongose = require('mongoose');

const favoriteProductsSchema = moongose.Schema({
  user_id: {
    type: moongose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },

  product_id: {
    type: moongose.Schema.Types.ObjectId,
    ref: 'Product',
    required: true,
  },
});

const FavProduct = moongose.model('FavProduct', favoriteProductsSchema);

module.exports = FavProduct;
