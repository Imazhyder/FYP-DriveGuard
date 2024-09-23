const Product = require('../model/product.model');
const PreferredProduct = require('../model/Car/preferedProducts');

exports.addProduct = async (req, res) => {
  console.log(req.body);
  try {
    const product = new Product(req.body);

    console.log(product);

    if (!product) {
      res
        .status(404)
        .json({ messgae: 'Product didnot created , Some Error occur' });
    }

    await product.save();
    res.status(200).json({ messgae: 'Product created Successfully' });
  } catch (error) {
    res.status(501).json({ message: error.message });
  }
};

exports.getProducts = async (req, res) => {
  try {
    const products = await Product.find({}).populate({
      path: 'Reviews_Rating.user_id',
      model: 'User',
      select: 'username',
    });
    if (!products) {
      res.status(404).json({ message: 'Product not Found' });
    }

    res.status(200).json(products);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.addReview = async (req, res) => {
  const { product_id } = req.params;
  try {
    const updatedProduct = await Product.findByIdAndUpdate(
      product_id,
      { $push: { Reviews_Rating: req.body } }, // Use $push to add the review to the array
      { runValidators: true } // Ensure validators run and return the updated document
    );

    if (!updatedProduct) {
      return res.status(404).json({ message: 'Product not found' });
    }

    res.status(200).json({ message: 'Your review has been added' });
  } catch (error) {
    res.status(500).json({
      message: 'Error adding review',
      error: error.message,
    });
  }
};

exports.deleteProduct = async (req, res) => {
  const { product_id } = req.params; // Or use req.body if the product ID is in the body
  try {
    const product = await Product.findByIdAndDelete(product_id);

    if (!product) {
      return res
        .status(400)
        .json({ message: 'No product found in the collection' });
    }

    const preferedProducts = await PreferredProduct.find();

    for (let item of preferedProducts) {
      let updated = false;

      // Check and update Oil_Filter
      ['first_priority', 'second_priority', 'third_priority'].forEach((key) => {
        if (
          item.modelProducts.Oil_Filter[key] &&
          item.modelProducts.Oil_Filter[key].equals(product_id)
        ) {
          item.modelProducts.Oil_Filter[key] = null;
          updated = true;
        }
      });

      // Check and update Air_Filter
      ['first_priority', 'second_priority', 'third_priority'].forEach((key) => {
        if (
          item.modelProducts.Air_Filter[key] &&
          item.modelProducts.Air_Filter[key].equals(product_id)
        ) {
          item.modelProducts.Air_Filter[key] = null;
          updated = true;
        }
      });

      // Check and update Car_Oil
      ['first_priority', 'second_priority', 'third_priority'].forEach((key) => {
        if (
          item.modelProducts.Car_Oil[key] &&
          item.modelProducts.Car_Oil[key].equals(product_id)
        ) {
          item.modelProducts.Car_Oil[key] = null;
          updated = true;
        }
      });

      // Save the document if it was updated
      if (updated) {
        await item.save();
      }
    }

    return res.status(200).json({ message: 'Product deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// exports.deleteProduct = async (req, res) => {
//   const { product_id } = req.params;
//   try {
//     const product = await Product.findByIdAndDelete(product_id);

//     if (!product) {
//       return res
//         .status(400)
//         .json({ message: 'No product Found in the Collection' });
//     }

//     const preferedProducts = await PreferredProduct.find({}, 'modelProducts');

//     for (let item of preferedProducts) {
//       if (item.modelProducts.Oil_Filter.first_priority === product_id) {
//         item.modelProducts.Oil_Filter.first_priority = null;
//         await item.save();
//       } else if (item.modelProducts.Oil_Filter.second_priority === product_id) {
//         item.modelProducts.Oil_Filter.second_priority = null;
//         await item.save();
//       } else if (item.modelProducts.Oil_Filter.third_priority === product_id) {
//         item.modelProducts.Oil_Filter.third_priority = null;
//         await item.save();
//       } else if (item.modelProducts.Air_Filter.first_priority === product_id) {
//         item.modelProducts.Air_Filter.first_priority = null;
//         await item.save();
//       } else if (item.modelProducts.Air_Filter.second_priority === product_id) {
//         item.modelProducts.Air_Filter.second_priority = null;
//         await item.save();
//       } else if (item.modelProducts.Air_Filter.third_priority === product_id) {
//         item.modelProducts.Air_Filter.third_priority = null;
//         await item.save();
//       } else if (item.modelProducts.Car_Oil.first_priority === product_id) {
//         item.modelProducts.Air_Filter.first_priority = null;
//         await item.save();
//       } else if (item.modelProducts.Car_Oil.second_priority === product_id) {
//         item.modelProducts.Air_Filter.second_priority = null;
//         await item.save();
//       } else {
//         item.modelProducts.Air_Filter.third_priority = null;
//         await item.save();
//       }
//     }

//     return res.status(200).json({ message: 'Product deleted Successfully' });
//   } catch (error) {
//     res.status(500).json({ message: error.message });
//   }
// };

// exports.category = async (req, res) => {
//   try {
//     const { category } = req.params;

//     // console.log(category);

//     const categoryProducts = await Product.find({ category: category });

//     console.log(categoryProducts);

//     if (!categoryProducts) {
//       res
//         .status(400)
//         .json({ message: 'There is no product in the Collection' });
//     }

//     res.status(200).json(categoryProducts);
//   } catch (error) {
//     res.status(500).json({ message: error.message });
//   }
// };
