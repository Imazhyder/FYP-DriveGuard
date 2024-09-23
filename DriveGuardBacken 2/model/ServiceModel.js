const moongose = require('mongoose');

const infoSchema = moongose.Schema({
  address: {
    type: String,
    required: true,
  },

  email: {
    type: String,
  },

  phone_no: {
    type: String,
    required: true,
  },
});

const serviceSchema = moongose.Schema({
  service_name: {
    type: String,
    unique: true,
    required: true,
  },

  imgUrl: {
    type: String,
  },

  price: {
    type: Number,
    required: true,
  },

  description: {
    type: String,
    required: true,
  },

  info: {
    type: infoSchema,
    required: true,
  },

  providedServices: [String],

  slots: [String],

  rating: {
    type: Number,
  },
});

const Service = moongose.model('Service', serviceSchema);

module.exports = Service;
