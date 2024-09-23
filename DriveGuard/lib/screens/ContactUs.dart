import 'package:bro/styles/EditProfiletext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Us"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              "You can get in touch with us through below platforms . Our Team will reach out to you as soon as it would be possible.",
              style: lightText,
            ),
            const Gap(20),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: height / 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.call),
                      title: Text(
                        'Contact Number',
                        style: lightText,
                      ),
                      subtitle: const Text('021-2673854'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.email),
                      title: Text(
                        'Email Address',
                        style: lightText,
                      ),
                      subtitle: const Text('SupportDriveGuard@gmail.com'),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(30),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.instagram,
                          size: 40, color: Colors.pink),
                      title: Text(
                        'Instagram',
                        style: lightText,
                      ),
                      subtitle: const Text('@DriveGuard.pk'),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.facebook,
                          size: 40, color: Colors.blue),
                      title: Text(
                        'Facebook',
                        style: lightText,
                      ),
                      subtitle: const Text('@DriveGuard.pk'),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.twitter,
                          size: 40, color: Colors.lightBlue),
                      title: Text(
                        'Twitter',
                        style: lightText,
                      ),
                      subtitle: const Text('@DriveGuard.pk'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
