import 'package:admin/Screens/Accounts/DeleteAccounts.dart';
import 'package:admin/Screens/Orders/CancelOrders.dart';
import 'package:admin/Screens/Orders/Orders.dart';
import 'package:admin/Screens/Products/AddProducts.dart';
import 'package:admin/Screens/Products/DeleteProduct.dart';
import 'package:admin/Screens/Services/AddService.dart';
import 'package:admin/Screens/Services/DeleteServices..dart';
import 'package:admin/Widgets/SideMenu/SideMenu.dart';
import 'package:flutter/material.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    // const DashBoardScreen(),
    const AddProductsScreen(),
    const DeleteProduct(),
    const DeleteAccounts(),
    const OrdersScreen(),
    const AddService(),
    const CancelOrders(),
    const DeleteServices()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              flex: 1,
              child: SideMenu(
                onIndexCallBack: (selectedIndex) {
                  setState(() {
                    this.selectedIndex = selectedIndex;
                  });
                },
              )),
          Expanded(flex: 5, child: pages[selectedIndex])
        ],
      ),
    );
  }
}
