import 'dart:convert';
import 'package:bro/screens/ChangePassword.dart';
import 'package:bro/screens/ContactUs.dart';
import 'package:bro/screens/EditProfile.dart';
import 'package:bro/screens/OrdersScreen.dart';
import 'package:bro/screens/WishList.dart';
import 'package:bro/screens/login.dart';
import 'package:bro/styles/bold_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProfileScreen extends ConsumerStatefulWidget {
  const UserProfileScreen({super.key});

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  String? user_id;
  String? userName;
  String? email;
  String? gender;
  String? country;
  String? address;

  bool _DataFetchprogress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("User Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
              child: Icon(
            Icons.person_2_outlined,
            size: 80,
          )),
          const SizedBox(
            height: 10,
          ),
          Center(
              child: BoldText(
            text: userName ?? "",
            fontSize: 16,
          )),
          _DataFetchprogress
              ? const Center(child: CircularProgressIndicator())
              : Center(child: BoldText(text: email ?? '', fontSize: 20)),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        email: email!,
                        username: userName!,
                        gender: gender ?? "",
                        country: country ?? "",
                        address: address ?? "",
                      ),
                    ));
              },
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              child: const Text("Edit Profile"),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite_border,
              size: 30,
            ),
            title: const Text(
              "Wish List",
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WishListScreen(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.shopping_bag_outlined,
              size: 30,
            ),
            title: const Text(
              "Orders",
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const OrdersScreen(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.lock_open_outlined,
              size: 30,
            ),
            title: const Text(
              "Change Password",
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePasswordScreen(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.contact_support_sharp,
              size: 30,
            ),
            title: const Text(
              "Contact Us",
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUsScreen(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 30,
            ),
            title: const Text(
              "LogOut",
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: _logout,
          )
        ],
      ),
    );
  }

  // Functions.......................//

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('user_id');
    // Navigate back to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<void> _fetchUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    setState(() {
      _DataFetchprogress = true;
    });

    try {
      if (token != null) {
        final response = await http.get(
          Uri.parse('http://localhost:3000/api/userData'),
          headers: {'Authorization': 'Bearer $token'},
        );

        if (response.statusCode == 200) {
          var userData = jsonDecode(response.body);

          print(userData);

          setState(() {
            user_id = userData['_id'];
            userName = userData['username'];
            email = userData['email'];
            gender = userData['Gender'];
            country = userData['country'];
            address = userData['address'];
          });
        }
      }
    } catch (error) {
      print(error);
    }

    setState(() {
      _DataFetchprogress = false;
    });
  }
}
