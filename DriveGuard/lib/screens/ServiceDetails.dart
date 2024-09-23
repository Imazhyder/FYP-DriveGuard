import 'package:bro/data/Servicesdata.dart';

import 'package:bro/screens/BookingForm.dart';
import 'package:bro/styles/bold_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';

class ServicesDetailsScreen extends StatelessWidget {
  const ServicesDetailsScreen({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Details"),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookingFormScreen(
                  service: service,
                ),
              ));
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 40),
          backgroundColor: const Color.fromRGBO(150, 117, 250, 1),
        ),
        child: const Text("Book Service"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(service.imgUrl),
              _RatingBar(service.rating.toDouble()),
              const Gap(10),
              Container(
                margin: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [..._info(service), _buildServicesList(service)],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _RatingBar(double initialRating) {
  return RatingBar.builder(
    initialRating: initialRating,
    direction: Axis.horizontal,
    allowHalfRating: true,
    ignoreGestures: true,
    itemCount: 5,
    itemSize: 30,
    itemPadding: const EdgeInsets.symmetric(horizontal: 3),
    itemBuilder: (context, _) => const Icon(
      Icons.star,
      color: Colors.amber,
    ),
    onRatingUpdate: (rating) {
      print(rating);
    },
  );
}

List<Widget> _info(Service service) {
  return [
    BoldText(text: "Description", fontSize: 20),
    Text(
      service.description,
      textAlign: TextAlign.justify,
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
    ),
    const Gap(10),
    BoldText(text: "Address", fontSize: 20),
    Text(service.Info['address']),
    const Gap(10),
    BoldText(text: "Contact Information", fontSize: 20),
    Text(
      'Phone no : ${service.Info['phone_no']}\nEmail: ${service.Info['email']}',
      style: const TextStyle(
          fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
    ),
    const Gap(10),
    BoldText(text: "Services Offered", fontSize: 20),
  ];
}

Widget _buildServicesList(Service service) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: service.slots.length,
    itemBuilder: (context, index) {
      return Text(
        '${index + 1} ${service.providedServices[index]}',
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black),
      );
    },
  );
}
