const Car = require('../../model/Car/Car');

exports.addCar = async (req, res) => {
  try {
    const { car_name, brand, models } = req.body;

    console.log(car_name, brand);

    if (!car_name || !brand) {
      res.json({ message: 'Any of the feilds are missing' });
      return;
    }

    const car = new Car({ car_name: car_name, brand: brand, models: models });

    await car.save();

    res.status(200).json({ car, messgae: 'Car successfully added' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.getAllCars = async (req, res) => {
  try {
    const cars = await Car.find({});

    if (!cars) {
      return res.json({ messgae: 'There are no cars in the list ' });
    }

    return res.status(200).json(cars);
  } catch (error) {
    return res.status(500).json({ message: 'Some Error Occured' });
  }
};
