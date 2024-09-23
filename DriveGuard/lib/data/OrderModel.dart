class OrderModel {
  OrderModel({
    required this.order_id,
    required this.order_products,
    required this.total_price,
    required this.status,
    required this.delivery_status,
  });
  String order_id;
  List<dynamic> order_products;
  int total_price;
  String status;
  String delivery_status;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      order_id: json['_id'],
      order_products: json['order_products'],
      total_price: json['total_price'],
      status: json['status'],
      delivery_status: json['delivery_status'],
    );
  }
}
