const CancelOrder = require('../model/CancelOrders');
const Order = require('../model/OrderModel');

exports.cancelRequest = async (req, res) => {
  const { order_id, user_id } = req.body;

  try {
    const order = await Order.findById(order_id);

    if (!order) {
      return res.status(404).json({ message: 'Order not found' }); // Use 404 for "Not Found"
    }

    const userOrders = await CancelOrder.find({ user_id });

    if (userOrders.length >= 2) {
      // Change to >= for safety
      return res.status(401).json({
        message:
          'User has already applied for cancel requests more than 2 times',
      });
    }

    const cancelRequest = await CancelOrder.create(req.body);

    if (!cancelRequest) {
      return res.status(400).json({ message: 'Request could not be created' });
    }

    return res
      .status(200)
      .json({ message: 'Cancel Request Created Successfully' });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

exports.getCancelRequest = async (req, res) => {
  try {
    const cancelOrders = await CancelOrder.find({});

    if (!cancelOrders) {
      return res.status(400).json({ message: 'There are no Cancel orders ' });
    }

    return res.status(200).json(cancelOrders);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
