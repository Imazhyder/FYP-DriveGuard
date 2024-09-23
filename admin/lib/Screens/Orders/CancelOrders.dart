import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:admin/Api/Orders.dart';
import 'package:admin/models/CancelOrderModel.dart';

class CancelOrders extends StatefulWidget {
  const CancelOrders({super.key});

  @override
  State<CancelOrders> createState() => _CancelOrdersState();
}

class _CancelOrdersState extends State<CancelOrders> {
  List<CancelOrderModel> allCancelOrders = [];
  List<CancelOrderModel> filteredCancelOrders = [];
  bool _isSearching = false;

  void _onSearchChanged(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _isSearching = true;
        filteredCancelOrders = allCancelOrders
            .where((cancelOrder) =>
                cancelOrder.user_id.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _isSearching = false;
        filteredCancelOrders = allCancelOrders;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cancel Request"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by user id',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: _onSearchChanged,
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<CancelOrderModel>>(
        future: OrderApi().getCancelOrderRequests(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cancel requests found'));
          } else {
            // Assign the fetched data to allCancelOrders only once
            allCancelOrders = snapshot.data!;
            if (!_isSearching) {
              filteredCancelOrders = allCancelOrders;
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: filteredCancelOrders.length,
              itemBuilder: (context, index) {
                final order = filteredCancelOrders[index];
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Text('Order ID: ${order.order_id}'),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('User ID: ${order.user_id}'),
                        const SizedBox(width: 5),
                        Text('Cancel ID: ${order.cancel_id}'),
                      ],
                    ),
                    tileColor: Colors.grey.withOpacity(0.2),
                    trailing: ElevatedButton(
                      onPressed: () {
                        _showDialog(context, DialogType.info,
                            "Do you want to approve Cancellation Request ? ",
                            () async {
                          final response = await OrderApi()
                              .changeOrderStatus(order.order_id, "cancel");

                          if (response.isNotEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(response)));

                            setState(() {});
                          }
                        }, () {});
                      },
                      child: const Text("Approved"),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showDialog(BuildContext context, DialogType dialogType, String title,
      void Function()? btnOkOnPress, void Function()? btnCancelOnPress) {
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      headerAnimationLoop: false,
      animType: AnimType.bottomSlide,
      title: title,
      buttonsTextStyle: const TextStyle(color: Colors.black),
      btnOkColor: Colors.green,
      btnCancelColor: Colors.white,
      showCloseIcon: true,
      btnOkOnPress: btnOkOnPress,
      btnCancelOnPress: btnCancelOnPress,
    ).show();
  }
}
