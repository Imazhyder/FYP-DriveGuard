const moongose = require('mongoose');

const modelSchema = moongose.Schema({
  name: {
    type: String,
  },
});

const carSchema = moongose.Schema({
  car_name: {
    type: String,
    required: true,
    unique: true,
  },

  brand: {
    type: String,
    required: true,
  },

  models: [modelSchema],
});

const Car = moongose.model('Car', carSchema);

module.exports = Car;

// const preferedProducts = moongose.Schema({});
