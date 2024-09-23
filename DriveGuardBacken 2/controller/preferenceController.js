const PreferredProduct = require('../model/Car/preferedProducts');

exports.addPreferedProduct = async (req, res) => {
  try {
    const { car_id, model_id } = req.body;

    // Check if the car_id already has any preferred product
    const foundCar = await PreferredProduct.findOne({ car_id: car_id });

    if (!foundCar) {
      // If no preferred product exists for the car_id, create a new one
      const preferredProduct = new PreferredProduct(req.body);
      await preferredProduct.save();
      return res
        .status(200)
        .json({ message: 'PreferredProduct Created Successfully' });
    } else {
      // If a preferred product exists for the car_id, check if the model_id is already associated with it
      const foundCombination = await PreferredProduct.findOne({
        car_id: car_id,
        model_id: model_id,
      });

      if (!foundCombination) {
        // If the model_id is not associated with the car_id, create a new preferred product
        const preferredProduct = new PreferredProduct(req.body);
        await preferredProduct.save();
        return res
          .status(200)
          .json({ message: 'PreferredProduct Created Successfully' });
      } else {
        // If the model_id is already associated with the car_id, return an error message
        return res
          .status(400)
          .json({ message: 'Car id and model id combination already exists' });
      }
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.updateModelProduct = async (req, res) => {
  try {
    const { car_id, model_id, product_id, priority, category } = req.body;

    const foundCarAndModel = await PreferredProduct.findOne({
      car_id: car_id,
      model_id: model_id,
    });

    if (!foundCarAndModel) {
      return res.status(400).json({ message: 'No combination found' });
    }

    if (priority === 'First Priority' && category === 'Oil Filter') {
      foundCarAndModel.modelProducts.Oil_Filter.first_priority = product_id;

      const p = await foundCarAndModel.save();
      console.log(p);
      return res
        .status(200)
        .json({ message: 'Model Product Updated Succesfully' });
    } else if (priority === 'Second Priority' && category === 'Oil Filter') {
      foundCarAndModel.modelProducts.Oil_Filter.second_priority = product_id;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Updated Succesfully' });
    } else if (priority === 'Third Priority' && category === 'Oil Filter') {
      foundCarAndModel.modelProducts.Oil_Filter.third_priority = product_id;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Updated Succesfully' });
    } else if (priority === 'First Priority' && category === 'Air Filter') {
      foundCarAndModel.modelProducts.Air_Filter.first_priority = product_id;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Updated Succesfully' });
    } else if (priority === 'Second Priority' && category === 'Air Filter') {
      foundCarAndModel.modelProducts.Air_Filter.second_priority = product_id;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Updated Succesfully' });
    } else if (priority === 'Third Priority' && category === 'Air Filter') {
      foundCarAndModel.modelProducts.Air_Filter.third_priority = product_id;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Updated Succesfully' });
    } else if (priority === 'First Priority' && category === 'Car Oil') {
      foundCarAndModel.modelProducts.Car_Oil.first_priority = product_id;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Updated Succesfully' });
    } else if (priority === 'Second Priority' && category === 'Car Oil') {
      foundCarAndModel.modelProducts.Car_Oil.second_priority = product_id;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Updated Succesfully' });
    } else {
      foundCarAndModel.modelProducts.Car_Oil.third_priority = product_id;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Updated Succesfully' });
    }
  } catch (error) {
    res
      .status(500)
      .json({ message: 'Some Error Occurred', error: error.message });
  }
};

exports.deleteModelProduct = async (req, res) => {
  try {
    const { car_id, model_id, priority, category } = req.body;

    const foundCarAndModel = await PreferredProduct.findOne({
      car_id: car_id,
      model_id: model_id,
    });

    if (!foundCarAndModel) {
      return res.status(400).json({ message: 'No combination found' });
    }

    if (priority === 'First Priority' && category === 'Oil Filter') {
      foundCarAndModel.modelProducts.Oil_Filter.first_priority = null;

      const p = await foundCarAndModel.save();
      console.log(p);
      return res
        .status(200)
        .json({ message: 'Model Product Deleted Succesfully' });
    } else if (priority === 'Second Priority' && category === 'Oil Filter') {
      foundCarAndModel.modelProducts.Oil_Filter.second_priority = null;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Deleted Succesfully' });
    } else if (priority === 'Third Priority' && category === 'Oil Filter') {
      foundCarAndModel.modelProducts.Oil_Filter.third_priority = null;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Deleted Succesfully' });
    } else if (priority === 'First Priority' && category === 'Air Filter') {
      foundCarAndModel.modelProducts.Air_Filter.first_priority = null;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Deleted Succesfully' });
    } else if (priority === 'Second Priority' && category === 'Air Filter') {
      foundCarAndModel.modelProducts.Air_Filter.second_priority = null;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Deleted Succesfully' });
    } else if (priority === 'Third Priority' && category === 'Air Filter') {
      foundCarAndModel.modelProducts.Air_Filter.third_priority = null;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Deleted Succesfully' });
    } else if (priority === 'First Priority' && category === 'Car Oil') {
      foundCarAndModel.modelProducts.Car_Oil.first_priority = null;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Deleted Succesfully' });
    } else if (priority === 'Second Priority' && category === 'Car Oil') {
      foundCarAndModel.modelProducts.Car_Oil.second_priority = null;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Deleted Succesfully' });
    } else {
      foundCarAndModel.modelProducts.Car_Oil.third_priority = null;

      await foundCarAndModel.save();
      return res
        .status(200)
        .json({ message: 'Model Product Deleted Succesfully' });
    }
  } catch (error) {
    res
      .status(500)
      .json({ message: 'Some Error Occurred', error: error.message });
  }
};

// exports.deleteModelProduct = async (req, res) => {
//   const { car_id, model_id, priority, category } = req.params;

//   console.log(priority);
//   console.log(category);

//   try {
//     const preferredProduct = await PreferredProduct.findOne({
//       car_id,
//       model_id,
//     });

//     if (!preferredProduct) {
//       return res
//         .status(400)
//         .json({ message: 'No preferred product found to delete' });
//     }

//     console.log(preferredProduct);

//     const categoryMap = {
//       'Oil Filter': 'Oil_Filter',
//       'Air Filter': 'Air_Filter',
//       'Car Oil': 'Car_Oil',
//     };

//     const priorityMap = {
//       'First Priority': 'first_priority',
//       'Second Priority': 'second_priority',
//       'Third Priority': 'third_priority',
//     };

//     const categoryKey = categoryMap[category];
//     const priorityKey = priorityMap[priority];

//     if (categoryKey && priorityKey) {
//       preferredProduct.modelProducts[categoryKey][priorityKey] = null;

//       await preferredProduct.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Successfully' });
//     } else {
//       return res.status(400).json({ message: 'Invalid category or priority' });
//     }
//   } catch (error) {
//     console.error(error);
//     return res.status(500).json({ message: error.message });
//   }
// };

// exports.deleteModelProduct = async (req, res) => {
//   const { car_id, model_id, priority, category } = req.params;

//   console.log(priority);
//   console.log(category);

//   try {
//     const preferredProduct = await PreferredProduct.findOne({
//       car_id: car_id,
//       model_id: model_id,
//     });

//     if (!preferredProduct) {
//       res.status(400).json({ message: 'No prefered Found to delete' });
//     }

//     console.log(preferredProduct);

//     if (priority === 'First Priority' && category === 'Oil Filter') {
//       preferredProduct.modelProducts.Oil_Filter.first_priority = null;

//       const p = await preferredProduct.save();
//       console.log(p);
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Succesfully' });
//     } else if (priority === 'Second Priority' && category === 'Oil Filter') {
//       preferredProduct.modelProducts.Oil_Filter.second_priority = null;

//       await preferredProduct.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Succesfully' });
//     } else if (priority === 'Third Priority' && category === 'Oil Filter') {
//       preferredProduct.modelProducts.Oil_Filter.third_priority = null;

//       await preferredProduct.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Succesfully' });
//     } else if (priority === 'First Priority' && category === 'Air Filter') {
//       preferredProduct.modelProducts.Air_Filter.first_priority = null;

//       await preferredProduct.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Succesfully' });
//     } else if (priority === 'Second Priority' && category === 'Air Filter') {
//       preferredProduct.modelProducts.Air_Filter.second_priority = null;

//       await preferredProduct.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Succesfully' });
//     } else if (priority === 'Third Priority' && category === 'Air Filter') {
//       preferredProduct.modelProducts.Air_Filter.third_priority = null;

//       await preferredProduct.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Succesfully' });
//     } else if (priority === 'First Priority' && category === 'Car Oil') {
//       preferredProduct.modelProducts.Car_Oil.first_priority = null;

//       await preferredProduct.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Succesfully' });
//     } else if (priority === 'Second Priority' && category === 'Car Oil') {
//       preferredProduct.modelProducts.Car_Oil.second_priority = null;

//       await preferredProduct.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Succesfully' });
//     } else {
//       preferredProduct.modelProducts.Car_Oil.third_priority = null;

//       await preferredProduct.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Deleted Succesfully' });
//     }
//   } catch (error) {
//     res.status(500).json({ message: error.message });
//   }
// };

// exports.updateModelProduct = async (req, res) => {
//   try {
//     const { car_id, model_id, product_id, priority, category } = req.body;

//     const foundCarAndModel = await PreferredProduct.findOne({
//       car_id: car_id,
//       model_id: model_id,
//     });

//     if (!foundCarAndModel) {
//       return res.status(400).json({ message: 'No combination found' });
//     }

//     if (priority === 'First Priority' && category === 'Oil Filter') {
//       foundCarAndModel.modelProducts.Oil_Filter.first_priority = product_id;

//       const p = await foundCarAndModel.save();
//       console.log(p);
//       return res
//         .status(200)
//         .json({ message: 'Model Product Updated Succesfully' });
//     } else if (priority === 'Second Priority' && category === 'Oil Filter') {
//       foundCarAndModel.modelProducts.Oil_Filter.second_priority = product_id;

//       await foundCarAndModel.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Updated Succesfully' });
//     } else if (priority === 'Third Priority' && category === 'Oil Filter') {
//       foundCarAndModel.modelProducts.Oil_Filter.third_priority = product_id;

//       await foundCarAndModel.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Updated Succesfully' });
//     } else if (priority === 'First Priority' && category === 'Air Filter') {
//       foundCarAndModel.modelProducts.Air_Filter.first_priority = product_id;

//       await foundCarAndModel.save();
//       return res
//         .status(200)
//         .json({ message: 'Model Product Updated Succesfully' });
//     }
//   } catch (error) {
//     res
//       .status(500)
//       .json({ message: 'Some Error Occurred', error: error.message });
//   }
// };

// exports.getpreferedProducts = async (req, res) => {
//   try {
//     const { car_id, model_id } = req.params;

//     const preferredProducts = await PreferredProduct.find({
//       car_id,
//       model_id,
//     })
//       .populate({
//         path: 'modelProducts.Oil_Filter.first_priority modelProducts.Oil_Filter.second_priority modelProducts.Oil_Filter.third_priority',

//         model: 'Product',
//       })
//       .populate({
//         path: 'modelProducts.Air_Filter.first_priority modelProducts.Air_Filter.second_priority modelProducts.Air_Filter.third_priority',
//         model: 'Product',
//         populate,
//       })
//       .populate({
//         path: 'modelProducts.Car_Oil.first_priority modelProducts.Car_Oil.second_priority modelProducts.Car_Oil.third_priority',
//         model: 'Product',
//       });
//     // .populate({
//     //   path: 'Reviews_Rating.user_id',
//     //   model: 'User',
//     // });
//     res.status(200).json(preferredProducts);
//   } catch (error) {
//     res
//       .status(500)
//       .json({ message: 'Some Error Occurred', error: error.message });
//   }
// };

exports.getpreferedProducts = async (req, res) => {
  try {
    const { car_id, model_id } = req.params;

    const preferredProducts = await PreferredProduct.find({
      car_id,
      model_id,
    })
      .populate({
        path: 'modelProducts.Oil_Filter.first_priority modelProducts.Oil_Filter.second_priority modelProducts.Oil_Filter.third_priority',
        model: 'Product',
        populate: {
          path: 'Reviews_Rating.user_id',
          model: 'User',
          select: 'username',
        },
      })
      .populate({
        path: 'modelProducts.Air_Filter.first_priority modelProducts.Air_Filter.second_priority modelProducts.Air_Filter.third_priority',
        model: 'Product',
        populate: {
          path: 'Reviews_Rating.user_id',
          model: 'User',
          select: 'username',
        },
      })
      .populate({
        path: 'modelProducts.Car_Oil.first_priority modelProducts.Car_Oil.second_priority modelProducts.Car_Oil.third_priority',
        model: 'Product',
        populate: {
          path: 'Reviews_Rating.user_id',
          model: 'User',
          select: 'username',
        },
      });

    res.status(200).json(preferredProducts);
  } catch (error) {
    res
      .status(500)
      .json({ message: 'Some Error Occurred', error: error.message });
  }
};
