const moongose = require('mongoose');

const ReviewsRatingSchema = moongose.Schema({
  user_id: {
    type: moongose.Schema.Types.ObjectId,
    ref: 'User',
  },

  rating: {
    type: Number,
    required: true,
  },

  review_Description: {
    type: String,
  },
});

const productSchema = moongose.Schema({
  product_name: {
    type: String,
    required: true,
    unique: true,
  },
  price: {
    type: Number,
    required: true,
  },

  decription: {
    type: String,
    required: true,
  },
  category: {
    type: String,
    enum: [
      'Car Oil',
      'Oil Filter',
      'Air Filter',
      'Gear Oil',
      'Battery',
      'Coolant',
      'Tyre',
      'Alloy Wheel',
      'Car Wax',
      'Spark plug',
      'Headlight',
      'Seat Cover',
      'Exhaust System',
      'Car Cover',
      'Microfiber Cloth',
    ],
  },
  imgUrl: {
    type: String,
    required: false,
    default: null,
  },

  Reviews_Rating: [ReviewsRatingSchema],
});

const Product = moongose.model('Product', productSchema);

module.exports = Product;
