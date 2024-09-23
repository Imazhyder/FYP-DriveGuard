class CarProduct {
  CarProduct(
      {required this.product_id,
      required this.product_name,
      required this.price,
      required this.description,
      required this.category,
      required this.imgUrl,
      this.prioirty,
      this.reviews});

  String product_id;
  String product_name;
  int price;
  String description;
  String category;
  int? prioirty;
  String imgUrl;
  List<dynamic>? reviews;
}
