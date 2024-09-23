class ProductModel {
  ProductModel({
    required this.product_id,
    required this.product_name,
    required this.price,
    required this.description,
    required this.category,
    required this.imgUrl,
  });

  String product_id;
  String product_name;
  int price;
  String description;
  String category;
  String imgUrl;

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      product_id: json['_id'],
      product_name: json['product_name'],
      price: json['price'],
      description: json['decription'],
      category: json['category'],
      imgUrl: json['imgUrl'],
    );
  }
}
