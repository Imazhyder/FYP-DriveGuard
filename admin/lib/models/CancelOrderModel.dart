class CancelOrderModel {
  CancelOrderModel(
      {required this.cancel_id, required this.order_id, required this.user_id});

  String cancel_id;
  String order_id;
  String user_id;

  factory CancelOrderModel.fromJson(Map<String, dynamic> json) {
    return CancelOrderModel(
        cancel_id: json['_id'],
        order_id: json['order_id'],
        user_id: json['user_id']);
  }
}
