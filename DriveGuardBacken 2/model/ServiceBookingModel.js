const moongose = require('mongoose');

const serviceBookingSchema = moongose.Schema({
  user_id: {
    type: moongose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },

  service_id: {
    type: moongose.Schema.Types.ObjectId,
    ref: 'Service',
    required: true,
  },

  selected_service: {
    type: String,
    required: true,
  },

  slot: {
    type: String,
    required: true,
  },

  paymentMethod: {
    type: String,
    enum: ['Cash on Delivery'],
  },
});

const ServiceBooking = moongose.model('ServiceBooking', serviceBookingSchema);

module.exports = ServiceBooking;
