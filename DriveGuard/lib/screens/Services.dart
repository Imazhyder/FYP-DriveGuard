import 'package:bro/data/Servicesdata.dart';
import 'package:bro/providers/servicesProvider.dart';
import 'package:bro/screens/ServiceDetails.dart';
import 'package:bro/styles/bold_text.dart';
import 'package:bro/widgets/ServicesCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Image.asset(
          "lib/assets/logo/WhatsApp_Image_2024-05-05_at_1.09.14_PM-removebg-preview.png",
          scale: 4,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(20),
            BoldText(text: "Certified Service Providers", fontSize: 20),
            Consumer(
              builder: (context, ref, child) {
                final services = ref.watch(serviceDataProvider);

                return services.when(
                  data: (data) {
                    return _displayServices(data);
                  },
                  error: (error, stackTrace) {
                    print(error.toString());
                    return Text(error.toString());
                  },
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _displayServices(List<Service> data) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: data.length,
      itemExtent: 150,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ServicesDetailsScreen(service: data[index]),
              ),
            );
          },
          child: ServiesCard(service: data[index]),
        );
      },
    );
  }
}
