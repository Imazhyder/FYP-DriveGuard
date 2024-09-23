const Service = require('../model/ServiceModel');
const ServiceBooking = require('../model/ServiceBookingModel');

exports.addService = async (req, res) => {
  try {
    const service = new Service(req.body);

    if (!service) {
      res
        .status(404)
        .json({ messgae: 'Service didnot created , Some Error occur' });
    }

    await service.save();
    res.status(200).json({ messgae: 'Service created Successfully' });
  } catch (error) {
    res.status(501).json({ message: error.message });
  }
};

exports.getServices = async (req, res) => {
  try {
    const services = await Service.find({});

    if (!services) {
      return res.json({ messgae: 'There are no cars in the list ' });
    }

    return res.status(200).json(services);
  } catch (error) {
    return res.status(500).json({ message: 'Some Error Occured' });
  }
};

exports.bookSerivce = async (req, res) => {
  try {
    const { user_id, service_id, selected_service, slot } = req.body;

    const userService = await ServiceBooking.findOne({
      user_id: user_id,
      service_id: service_id,
      selected_service: selected_service,
      slot: slot,
    });

    if (!userService) {
      const newService = await ServiceBooking.create(req.body);
      return res.status(200).json({ message: 'Your Service is booked' });
    }

    res.status(400).json({ message: 'You already booked this service' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deleteService = async (req, res) => {
  try {
    const { service_id } = req.params;

    const deletedService = await Service.findByIdAndDelete(service_id);

    if (!deletedService) {
      return res.status(404).json({ message: 'Service not found' });
    }

    res.status(200).json({
      message: 'Service deleted successfully',
    });
  } catch (error) {
    res.status(500).json({
      message: 'An error occurred while deleting the service',
      error: error.message,
    });
  }
};
