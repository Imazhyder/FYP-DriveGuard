import 'package:hive/hive.dart';

import 'cart_item_model.dart';
part 'user_cart_model.g.dart';

@HiveType(typeId: 1)
class UserCart extends HiveObject {
  @HiveField(0)
  late String user_id;

  @HiveField(1)
  late List<CartItem> cart_items;

  @HiveField(2)
  late double total_price_of_cart;
}
