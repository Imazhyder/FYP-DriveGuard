import 'package:bro/data/Servicesdata.dart';
import 'package:flutter/material.dart';

class ServiesCard extends StatelessWidget {
  ServiesCard({super.key, required this.service});

  Service service;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 100,
            child: Image.network(
              service.imgUrl,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                service.name,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: Colors.black),
              ),
              Text(
                '\ from PKR ${service.price}',
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                    color: Color.fromARGB(255, 3, 47, 82)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
