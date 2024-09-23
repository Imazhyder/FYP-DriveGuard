import 'package:bro/data/CartItemModel.dart';
import 'package:bro/providers/cartprovider.dart';
import 'package:bro/styles/EditProfiletext.dart';
import 'package:bro/styles/Light_Text.dart';
import 'package:bro/styles/card_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class CartItemCard extends ConsumerStatefulWidget {
  CartItemCard({super.key, required this.cartItem});

  ProductCartItem cartItem;

  @override
  ConsumerState<CartItemCard> createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<CartItemCard> {
  void _addQuantity() {
    ref.read(cartProvider.notifier).updateQuantity(
          widget.cartItem.product_id,
          widget.cartItem.initial_quantity + 1,
        );
  }

  void _subtractQuantity() {
    if (widget.cartItem.initial_quantity > 1) {
      ref.read(cartProvider.notifier).updateQuantity(
            widget.cartItem.product_id,
            widget.cartItem.initial_quantity - 1,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      child: Container(
        height: 120,
        width: width,
        decoration: const BoxDecoration(color: Colors.white30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductImage(widget.cartItem.imgUrl),
            const Gap(10),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(5),
                  Flexible(
                    child: Text(
                      widget.cartItem.product_name,
                      overflow: TextOverflow.ellipsis,
                      style: editProfileText,
                      softWrap: false,
                    ),
                  ),
                  const Gap(7),
                  Light_Text(
                    text: "\PKR ${widget.cartItem.total_price}",
                    fontSize: 15,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 29,
                          height: 29,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: Colors.black38, width: 1.0),
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.only(left: 2),
                            onPressed: _addQuantity,
                            icon: const Icon(Icons.keyboard_arrow_up),
                          ),
                        ),
                        const Gap(15),
                        Light_Text(
                          text: "${widget.cartItem.initial_quantity}",
                          fontSize: 15,
                        ),
                        const Gap(15),
                        Container(
                          width: 29,
                          height: 29,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border:
                                Border.all(color: Colors.black38, width: 1.0),
                          ),
                          child: IconButton(
                            padding: const EdgeInsets.only(left: 2),
                            onPressed: _subtractQuantity,
                            icon: const Icon(Icons.keyboard_arrow_down),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black38, width: 1.0),
                ),
                child: IconButton(
                  padding: const EdgeInsets.only(left: 2),
                  onPressed: () {
                    ref.read(cartProvider.notifier).removeItem(widget.cartItem);
                  },
                  icon: const Icon(Icons.delete_outline),
                ),
              ),
            ),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}

Widget _buildProductImage(String imageURL) {
  return Container(
    margin: const EdgeInsets.only(left: 5, top: 5),
    height: 110,
    width: 110,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.withOpacity(0.2),
    ),
    child: CachedNetworkImage(
      imageUrl: imageURL,
      fit: BoxFit.cover,
      placeholder: (context, url) => const SizedBox(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    ),
  );
}
