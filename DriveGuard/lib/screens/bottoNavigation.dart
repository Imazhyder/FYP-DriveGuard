import 'package:bro/providers/FavProvider.dart';
import 'package:bro/screens/Search.dart';
import 'package:bro/screens/Services.dart';
import 'package:bro/screens/UserProfile.dart';
import 'package:bro/screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BotttomNavigationScreen extends ConsumerStatefulWidget {
  @override
  _BotttomNavigationScreen createState() => _BotttomNavigationScreen();
}

class _BotttomNavigationScreen extends ConsumerState<BotttomNavigationScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(favProductProvider.notifier).getFavProducts();
  }

  int _selectedIndex = 0;
  TextStyle optionStyle =
      const TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = [
    HomeScreen(),
    SearchScreen(),
    ServicesScreen(),
    UserProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.car_repair,
                  text: 'Services',
                ),
                GButton(
                  icon: Icons.verified_user,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
