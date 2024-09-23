const FavProduct = require('../model/FavoriteModel');

exports.addToFav = async (req, res) => {
  try {
    const { user_id, product_id } = req.body;

    // console.log(req.body);

    const favProduct = await FavProduct.findOne({
      user_id: user_id,
      product_id: product_id,
    });

    if (!favProduct) {
      const newFavProduct = new FavProduct({
        user_id: user_id,
        product_id: product_id,
      }); // Corrected instantiation
      await newFavProduct.save();

      return res.status(200).json({
        success: true,
        message: 'Item added successfully',
        data: newFavProduct,
      });
    } else {
      await FavProduct.findOneAndDelete({
        user_id: user_id,
        product_id: product_id,
      });
      return res.status(201).json({
        success: true,
        message: 'Item removed from wishlist',
        data: {},
      });
    }
  } catch (error) {
    return res.json({
      success: false,
      message: `Product cannot be added to favorites: ${error}`,
    });
  }
};

exports.getFavData = async (req, res) => {
  try {
    const user_id = req.params.user_id; // Corrected parameter

    const foundFavProducts = await FavProduct.find({
      user_id: user_id,
    }).populate('product_id');

    if (foundFavProducts.length === 0) {
      return res.json({
        success: false,
        data: [],
        message: 'There are no favorite products in your list',
      });
    }

    return res.json(foundFavProducts);
  } catch (error) {
    return res.json({ success: false, message: error.message });
  }
};
