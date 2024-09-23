import 'package:bro/data/productdata.dart';
import 'package:bro/providers/FavProvider.dart';
import 'package:bro/styles/EditProfiletext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends ConsumerStatefulWidget {
  ProductCard({
    super.key,
    required this.carProduct,
    this.index,
    required this.onShowHeartIcon,
    this.heroTag, // Optional heroTag parameter
  });

  CarProduct carProduct;
  int? index;
  final bool onShowHeartIcon;
  final String? heroTag; // Optional heroTag parameter

  @override
  ConsumerState<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends ConsumerState<ProductCard> {
  @override
  Widget build(BuildContext context) {
    var listOfFavProducts = ref.watch(favProductProvider);
    var isFavorite = listOfFavProducts
        .any((product) => product.product_id == widget.carProduct.product_id);

    // Placeholder image URL in case the actual URL is empty or null
    final placeholderImageUrl = 'https://via.placeholder.com/150';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.carProduct.prioirty != null)
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: Text(
              'Preference: ${widget.carProduct.prioirty}',
              style: editProfileText,
            ),
          ),
        Card(
          surfaceTintColor: Colors.white,
          elevation: 3,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 40, right: 10, left: 10, bottom: 20),
                child: widget.heroTag != null
                    ? Hero(
                        tag: widget.heroTag!, // Use the provided heroTag
                        child: CachedNetworkImage(
                          imageUrl: widget.carProduct.imgUrl.isNotEmpty
                              ? widget.carProduct.imgUrl
                              : placeholderImageUrl,
                          width: 190,
                          height: 230,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )
                    : (widget.index != null
                        ? Hero(
                            tag: widget.index!,
                            child: CachedNetworkImage(
                              imageUrl: widget.carProduct.imgUrl.isNotEmpty
                                  ? widget.carProduct.imgUrl
                                  : placeholderImageUrl,
                              width: 190,
                              height: 230,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: widget.carProduct.imgUrl.isNotEmpty
                                ? widget.carProduct.imgUrl
                                : placeholderImageUrl,
                            width: 190,
                            height: 230,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          )),
              ),
              if (widget.onShowHeartIcon &&
                  widget.carProduct.product_name.isNotEmpty)
                Positioned.fill(
                  bottom: 170,
                  left: 120,
                  child: IconButton(
                    onPressed: () {
                      ref
                          .read(favProductProvider.notifier)
                          .addAndRemoveFromFav(widget.carProduct, context);
                    },
                    icon: isFavorite
                        ? Icon(Icons.favorite)
                        : Image.asset(
                            "lib/assets/images/heart.png",
                            cacheHeight: 30,
                          ),
                  ),
                )
            ],
          ),
        ),
        const Gap(5),
        Text(
          widget.carProduct.category,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        Flexible(
          child: Text(
            widget.carProduct.product_name,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            softWrap: true,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
          ),
        ),
        Text(
          '\PKR ${widget.carProduct.price}',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
        ),
      ],
    );
  }
}
