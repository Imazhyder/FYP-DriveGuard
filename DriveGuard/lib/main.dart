import 'package:bro/Hive/cart_item_model.dart';
import 'package:bro/Hive/user_cart_model.dart';
import 'package:bro/screens/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(UserCartAdapter());
  await Hive.openBox<UserCart>('userCartBox');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DriveGuard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        // You can customize the dark theme here
      ),
      themeMode:
          ThemeMode.system, // Automatically switch based on system setting
      // Set the initial route to SignupScreen
      // initialRoute: '/signup',
      // routes: {
      //   // Define routes for the app
      //   '/signup': (context) => SignupScreen(),
      // },
      home: const SplashScreen(),
    );
  }
}

//
