import 'package:hive/hive.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 0)
class CartItem extends HiveObject {
  CartItem(this.product_id, this.name, this.initial_quantity, this.price,
      this.total_price, this.imgUrl);
  @HiveField(0)
  late String product_id;

  @HiveField(1)
  late String name;

  @HiveField(2)
  late int initial_quantity;

  @HiveField(3)
  late double price;

  @HiveField(4)
  late double total_price;

  @HiveField(5)
  late String imgUrl;
}
