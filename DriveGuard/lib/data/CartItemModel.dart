class ProductCartItem {
  String product_id;
  String product_name;
  String imgUrl;
  double price;
  int initial_quantity;
  double total_price;

  ProductCartItem({
    required this.product_id,
    required this.product_name,
    required this.imgUrl,
    required this.price,
    this.initial_quantity = 1,
  }) : total_price = price * initial_quantity;

  ProductCartItem copyWith({
    String? product_id,
    String? product_name,
    String? imgUrl,
    double? price,
    int? initial_quantity,
    double? total_price,
  }) {
    return ProductCartItem(
      product_id: product_id ?? this.product_id,
      product_name: product_name ?? this.product_name,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
      initial_quantity: initial_quantity ?? this.initial_quantity,
    )..total_price =
        (price ?? this.price) * (initial_quantity ?? this.initial_quantity);
  }
}
