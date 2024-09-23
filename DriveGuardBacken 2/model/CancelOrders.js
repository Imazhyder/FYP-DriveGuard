const moongose = require('mongoose');

const cancelOrdersSchema = moongose.Schema({
  order_id: {
    type: moongose.Schema.Types.ObjectId,
    ref: 'Order',
    required: true,
    unique: true,
  },

  user_id: {
    type: moongose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
});

const CancelOrder = moongose.model('CancelOrder', cancelOrdersSchema);

module.exports = CancelOrder;
