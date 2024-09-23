class Service {
  Service(
      {required this.service_id,
      required this.name,
      required this.imgUrl,
      required this.price,
      required this.providedServices,
      required this.slots,
      required this.description,
      required this.Info,
      required this.rating});
  String service_id;
  String name;
  String imgUrl;
  int price;
  String description;
  Map<String, dynamic> Info;
  List<dynamic> providedServices;
  List<dynamic> slots;
  int rating;

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
        service_id: json['_id'],
        name: json['service_name'],
        imgUrl: json['imgUrl'],
        price: json['price'],
        providedServices: json['providedServices'],
        slots: json['slots'],
        description: json['description'],
        Info: json['info'],
        rating: json['rating']);
  }
}

// List<ServicesData> servicesData = [
//   ServicesData(
//       service_id: "123",
//       name: 'Speedy Fix Auto',
//       imgUrl: 'lib/assets/images/service 1.png',
//       price: 2000,
//       description:
//           "Speedy Autofix  offers expert automotive care to keep your vehicle running smoothly and safely. With a focus on quality workmanship and exceptional customer service, our skilled mechanics provide a range of services from routine maintenance to complex repairs. At Speedy Autofix, we prioritize your satisfaction and the health of your car, ensuring it stays in peak condition mile after mile.",
//       Info: {
//         'address': "Shop 124/12, Main Tariq Road, Karachi, Sindh",
//         'email': 'Speedyautofix@gmail.com',
//         'phone_no': '021 - 417171'
//       },
//       providedServices: [
//         "Air Conditioning System Recharge",
//         "Engine Swapping",
//         "Mechanical Inspection",
//       ],
//       slots: [
//         "3/04/2024 - 12:00am",
//         "4/04/2024 - 01:00pm",
//         "4/04/2024 - 02:00pm"
//       ],
//       rating: 3),
//   ServicesData(
//       service_id: "123",
//       name: 'GearHead Garage',
//       imgUrl: 'lib/assets/images/service 2.png',
//       price: 3000,
//       description:
//           "GearHead Garage is your go-to destination for automotive excellence. As a trusted name in mechanical expertise, we're dedicated to keeping your vehicle performing at its peak. With a team of passionate mechanics and state-of-the-art equipment, we provide unparalleled service and customer satisfaction. Whether you need routine maintenance or complex repairs, GearHead Garage is committed to delivering top-quality workmanship and reliable solutions for all your automotive needs. ",
//       Info: {
//         'address': "Shop 314/42, 13th Lane, PECHS Block 4, Karachi, Sindh.",
//         'email': 'Gearhead@gmail.com',
//         'phone_no': '021-2313345'
//       },
//       providedServices: [
//         "Suspension System Overhaul",
//         "Electrical System Diagnostics and Repair",
//         "Performance Tuning and Upgrades",
//       ],
//       slots: [
//         "3/04/2024 - 12:00am",
//         "4/04/2024 - 01:00pm",
//         "4/04/2024 - 02:00pm"
//       ],
//       rating: 4),
//   ServicesData(
//       service_id: "123",
//       name: 'Apex Detailing',
//       imgUrl: 'lib/assets/images/service 3.png',
//       price: 4000,
//       description:
//           "At Apex Detailing, we're passionate about transforming vehicles into works of art, inside and out. With a keen eye for detail and a dedication to excellence, our skilled technicians employ industry-leading techniques and premium products to rejuvenate and protect your vehicle's appearance. From paint correction to interior deep cleaning, every service at Apex Detailing is executed with precision and care, ensuring your vehicle looks its absolute best. Experience the pinnacle of automotive detailing with Apex Detailing, where luxury meets perfection. ",
//       Info: {
//         'address': "Shop 141/1, Main Khalid bin Waleed road, Karachi, Sindh.",
//         'email': 'apexdetailing@gmail.com',
//         'phone_no': '021-4124711'
//       },
//       providedServices: [
//         'Glass Coating',
//         'Ceramic Coating',
//         'Interior Cleaning',
//       ],
//       slots: [
//         "3/04/2024 - 12:00am",
//         "4/04/2024 - 01:00pm",
//         "4/04/2024 - 02:00pm"
//       ],
//       rating: 5),
//   ServicesData(
//       service_id: "123",
//       name: 'Wheels and Wrenches',
//       imgUrl: 'lib/assets/images/service 4.png',
//       price: 5000,
//       description:
//           "Wheels and Wrenches is your one-stop destination for all things wheels and tires. As a premier wheel shop, we specialize in providing top-quality tires and alloys to enhance the performance and style of your vehicle. At Wheels and Wrenches, we understand that your wheels are more than just a functional necessity; they're a reflection of your personality and taste. That's why we offer a curated selection of the finest tires and alloys, sourced from leading manufacturers to ensure superior quality and durability. Additionally, our expert technicians are equipped to perform precision wheel alignment and balancing services, ensuring optimal handling and tire wear for a smooth and safe driving experience. Experience unparalleled expertise and customer service at Wheels and Wrenches, where your satisfaction is our top priority. ",
//       Info: {
//         'address': "Shop 12/1, 10th street, Dha phase 2, Karachi, Sindh.",
//         'email': 'wheelsandw@gmail.com',
//         'phone_no': '021-4182155'
//       },
//       providedServices: [
//         'Wheel Balancing',
//         'Wheel allignent',
//         'Tyre change',
//       ],
//       slots: [
//         "3/04/2024 - 12:00am",
//         "4/04/2024 - 01:00pm",
//         "4/04/2024 - 02:00pm"
//       ],
//       rating: 5),
// ];
