import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bro/data/Servicesdata.dart';
import 'package:bro/providers/bookingFormProvider.dart';
import 'package:bro/providers/servicesProvider.dart';
import 'package:bro/screens/bottoNavigation.dart';
import 'package:bro/styles/bold_text.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookingFormScreen extends StatelessWidget {
  const BookingFormScreen({super.key, required this.service});

  final Service service;

  @override
  Widget build(BuildContext context) {
    print("BuildContext is called");

    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Image.asset(
          "lib/assets/logo/WhatsApp_Image_2024-05-05_at_1.09.14_PM-removebg-preview.png",
          scale: 4,
        ),
      ),
      body: Card(
        margin: const EdgeInsets.all(30),
        elevation: 15,
        child: Container(
          height: 500,
          width: 400,
          decoration: const BoxDecoration(color: Colors.white),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Consumer(
                builder: (context, ref, child) {
                  print("Only Column is called");
                  final selectedService = ref.watch(selectedServiceProvider);
                  final selectedSlot = ref.watch(selectedSlotProvider);
                  final paymentMethod = ref.watch(paymentMethodProvider);

                  return Column(
                    children: [
                      BoldText(text: "Booking Form", fontSize: 20),
                      Expanded(
                        child: _dropdownMenuItem(
                          hint: "Select Service",
                          value: selectedService,
                          items: service.providedServices,
                          validatorText: "Please Select Service",
                          onChanged: (value) {
                            ref.read(selectedServiceProvider.notifier).state =
                                value;
                          },
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: _dropdownMenuItem(
                          hint: "Select Slot",
                          value: selectedSlot,
                          items: service.slots,
                          validatorText: "Please Select Slot",
                          onChanged: (value) {
                            ref.read(selectedSlotProvider.notifier).state =
                                value;
                          },
                        ),
                      ),
                      const Gap(20),
                      Expanded(
                        child: _dropdownMenuItem(
                          hint: "Select Payment Method",
                          value: paymentMethod,
                          items: ["Cash on Delivery"],
                          validatorText: "Please Select Payment Method",
                          onChanged: (value) {
                            ref.read(paymentMethodProvider.notifier).state =
                                value!;
                          },
                        ),
                      ),
                      const Gap(30),
                      _elevatedButton(_formKey, selectedService ?? "",
                          selectedSlot ?? "", paymentMethod, service.service_id)
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _dropdownMenuItem({
  required String hint,
  required String? value,
  required List items,
  required String validatorText,
  required ValueChanged<String?> onChanged,
}) {
  return DropdownButtonFormField<String>(
    value: value,
    hint: Text(hint),
    items: items.map((e) {
      return DropdownMenuItem<String>(
        value: e,
        child: Text(
          e,
        ),
      );
    }).toList(),
    onChanged: (value) {
      onChanged(value);
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return validatorText;
      }
      return null;
    },
  );
}

Widget _elevatedButton(GlobalKey<FormState> _formKey, String selected_service,
    String slot, String paymentMethod, String service_id) {
  return Consumer(builder: (context, ref, child) {
    bool isLoding = ref.watch(isLodingProvider);
    return isLoding
        ? const CircularProgressIndicator()
        : ElevatedButton(
            onPressed: () async {
              final isValid = _formKey.currentState!.validate();

              if (!isValid) {
                return;
              }

              _formKey.currentState!.save();

              final response = await ref.read(serviceProvider).bookService(
                  service_id, selected_service, slot, paymentMethod);

              if (!context.mounted) {
                return;
              }

              if (response.statusCode == 200) {
                showDialogbox(
                  context,
                  "Service Booked",
                  DialogType.success,
                  (p0) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BotttomNavigationScreen(),
                      )),
                );
              } else {
                showDialogbox(context, "This service is already booked",
                    DialogType.info, null);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(150, 117, 250, 1),
              fixedSize: const Size(130, 50),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(color: Colors.white),
            ),
          );
  });
}

void showDialogbox(BuildContext context, String text, DialogType dialogType,
    void Function(DismissType)? onDismissCallback) {
  AwesomeDialog(
          context: context,
          dialogType: dialogType,
          headerAnimationLoop: false,
          animType: AnimType.topSlide,
          title: text,
          buttonsTextStyle: const TextStyle(color: Colors.black),
          transitionAnimationDuration: const Duration(milliseconds: 200),
          autoHide: const Duration(seconds: 2),
          onDismissCallback: onDismissCallback)
      .show();
}
