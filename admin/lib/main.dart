import 'package:admin/Scaffolds/Desktop.dart';
import 'package:admin/Scaffolds/Mobile.dart';
import 'package:admin/Scaffolds/tab.dart';
import 'package:admin/Screens/DashBoard/DashBoard.dart';
import 'package:admin/Screens/Products/AddProducts.dart';
import 'package:admin/firebase_options.dart';
import 'package:admin/responsive.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // builder: (context, child) => ResponsiveBreakpoints(breakpoints: const [
      //    Breakpoint(start: 0, end: 450, name: MOBILE),
      //    Breakpoint(start: 451, end: 800, name: TABLET),
      //    Breakpoint(start: 801, end: 1920, name: DESKTOP),
      //    Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      // ], child: child!),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      routes: {
        '/dashboard': (context) => const DashBoardScreen(),
        '/products': (context) => const AddProductsScreen()
      },
      theme: ThemeData(
        textTheme: const TextTheme(),
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.lightBlue, brightness: Brightness.light),
        useMaterial3: true,
      ),
      home: const ResponsiveLayout(
          mobileScaffold: MobileScaffold(),
          tabletScaffold: TabScaffold(),
          desktopScaffold: DesktopScaffold()),
    );
  }
}
