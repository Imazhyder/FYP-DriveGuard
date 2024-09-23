import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bro/Api_Service/CancelOrders.dart';
import 'package:bro/data/OrderModel.dart';
import 'package:bro/providers/ordersProvider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: FutureBuilder<List<OrderModel>>(
        future: ref.read(ordersProvider).fetchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No orders found'));
          } else {
            var orders = snapshot.data!;

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) => Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                child: ExpansionTile(
                  leading: orders[index].delivery_status != "cancel"
                      ? IconButton(
                          onPressed: () {
                            _showDialog(context, DialogType.question,
                                "Do you want to cancel the order", () async {
                              final response = await CancelOrderRequest()
                                  .cancelRequest(orders[index].order_id);

                              if (response.isNotEmpty) {
                                _showDialog(context, DialogType.info, response,
                                    () {}, null);
                              }
                            }, null);
                          },
                          icon: const Icon(Icons.cancel))
                      : null,
                  title: Text("Order # ${orders[index].order_id}"),
                  tilePadding: const EdgeInsets.all(5),
                  subtitle: _totalPriceContainer(
                      orders[index].total_price.toString()),
                  trailing: _trailingContainer(orders[index].delivery_status),
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
                    _subListofExpansionTile(orders[index].order_products),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
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
    width: 80,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 233, 101, 45),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Center(
      child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
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

void _showDialog(BuildContext context, DialogType dialogType, String title,
    void Function()? btnOkOnPress, void Function()? btnCancelOnPress) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    headerAnimationLoop: false,
    animType: AnimType.bottomSlide,
    title: title,
    buttonsTextStyle: const TextStyle(color: Colors.black),
    btnOkColor: Colors.orange,
    btnCancelColor: Colors.white,
    showCloseIcon: true,
    btnOkOnPress: btnOkOnPress,
    btnCancelOnPress: btnCancelOnPress,
  ).show();
}
