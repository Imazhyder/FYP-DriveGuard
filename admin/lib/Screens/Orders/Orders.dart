import 'package:admin/Api/Orders.dart';
import 'package:admin/models/OrderModel.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<OrderModel> allOrdersData = [];
  List<OrderModel> filteredOrders = [];
  bool _isSearching = false;

  void _onSearchChanged(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _isSearching = true;
        filteredOrders = allOrdersData
            .where((order) =>
                order.order_id.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _isSearching = false;
        filteredOrders = allOrdersData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search by Order ID',
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
      body: FutureBuilder<List<OrderModel>>(
        future: OrderApi().getAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found'));
          } else {
            allOrdersData = snapshot.data!;
            filteredOrders = _isSearching ? filteredOrders : allOrdersData;

            return ListView.builder(
              itemCount: filteredOrders.length,
              itemBuilder: (context, index) => Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: ExpansionTile(
                  leading:
                      Text("Order id # \n ${filteredOrders[index].order_id}"),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("user id # \n  ${filteredOrders[index].user_id}"),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                          "Transaction id # \n  ${filteredOrders[index].transaction_id}"),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                          "Total Price = ${filteredOrders[index].total_price}"),
                      _trailingContainer(filteredOrders[index].delivery_status),
                    ],
                  ),
                  tilePadding: const EdgeInsets.all(5),
                  trailing:
                      filteredOrders[index].delivery_status == "delivered" ||
                              filteredOrders[index].delivery_status == "cancel"
                          ? null
                          : IconButton(
                              onPressed: () {
                                _showDialog(context, DialogType.warning,
                                    "Do you want to set status to delivered",
                                    () async {
                                  final response = await OrderApi()
                                      .changeOrderStatus(
                                          filteredOrders[index].order_id,
                                          "delivered");

                                  if (response.isNotEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(response)));

                                    setState(() {});
                                  }
                                }, () {});
                              },
                              icon: Icon(Icons.check)),
                  collapsedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  children: [
                    _subListofExpansionTile(
                        filteredOrders[index].order_products),
                  ],
                ),
              ),
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

Widget _subListofExpansionTile(List<dynamic> order_products) {
  return SizedBox(
    height: 300,
    child: ListView.builder(
      itemCount: order_products.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Product Name: ${order_products[index]['product_id']['product_name']}"),
                  Text("Quantity: ${order_products[index]['quantity']}"),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 100,
                width: 100,
                child: Center(
                  child: CachedNetworkImage(
                    imageUrl: order_products[index]['product_id']['imgUrl'],
                    width: 190,
                    height: 230,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _trailingContainer(String text) {
  return Container(
    height: 40,
    width: 100,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 233, 101, 45),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: FittedBox(
        child: Text(
          text,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
        ),
      ),
    ),
  );
}

Widget _totalPriceContainer(String total_price) {
  return Container(
    height: 30,
    width: 70,
    margin: const EdgeInsets.only(top: 10),
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 233, 101, 45),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        "Total Price = $total_price PKR",
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
