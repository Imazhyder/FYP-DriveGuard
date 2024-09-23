const Order = require('../model/OrderModel');
const User = require('../model/usermodel');
const CancelOrder = require('../model/CancelOrders');

exports.addOrder = async (req, res) => {
  // const { order_products, user_id, total_price, payment_method } = req.body;

  const { user_id } = req.body;
  try {
    const user = await User.findById(user_id);

    if (user.address === null) {
      return res.status(401).json({ message: 'Address not uploaded' });
    }

    // const order = new Order({
    //   order_products: order_products,
    //   user_id: user_id,
    //   total_price: total_price,
    //   payment_method: payment_method,
    // });

    await Order.create(req.body);

    return res.status(200).json({ message: 'Order Created Successfuly ' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getOrders = async (req, res) => {
  const { user_id } = req.params;

  try {
    const userorders = await Order.find({ user_id: user_id })
      .select([
        'order_products',
        'total_price',
        'status',
        'transaction_id',
        'delivery_status',
      ])
      .populate({
        path: 'order_products.product_id',
        model: 'Product',
        select: ['product_name', 'imgUrl'],
      });

    if (!userorders) {
      return res.status(300).json({ message: 'User has no orders' });
    }

    // Remove transaction_id from the response if it is null
    const ordersWithFilteredTransactionId = userorders.map((order) => {
      const orderObj = order.toObject();
      if (orderObj.transaction_id === null) {
        delete orderObj.transaction_id;
      }
      return orderObj;
    });

    return res.status(200).json(ordersWithFilteredTransactionId);
  } catch (error) {
    res.json({ message: error.message });
  }
};

exports.getAllOrders = async (req, res) => {
  try {
    const orders = await Order.find({})
      .select([
        'order_products',
        'total_price',
        'status',
        'transaction_id',
        'delivery_status',
        'user_id',
      ])
      .populate({
        path: 'order_products.product_id',
        model: 'Product',
        select: ['product_name', 'imgUrl'],
      });

    return res.status(200).json(orders);
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

exports.changeOrderStatus = async (req, res) => {
  const { order_id, delivery_status } = req.body;

  // Validate inputs
  if (!order_id || !delivery_status) {
    return res
      .status(400)
      .json({ message: 'Invalid order ID or delivery status' });
  }

  try {
    const order = await Order.findByIdAndUpdate(
      order_id,
      { delivery_status: delivery_status },
      { new: true, runValidators: true }
    );

    if (!order) {
      return res.status(404).json({ message: 'Order not found' });
    }

    await CancelOrder.findOneAndDelete({ order_id: order_id });

    return res.status(200).json({ message: 'Status Updated' });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};
