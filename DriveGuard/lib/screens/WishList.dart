import 'package:bro/providers/FavProvider.dart';
import 'package:bro/screens/productdetails.dart';
import 'package:bro/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishListScreen extends ConsumerStatefulWidget {
  const WishListScreen({super.key});

  @override
  ConsumerState<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends ConsumerState<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WishList"),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final favCarProducts = ref.watch(favProductProvider);
          final isLoading = ref.watch(favProductProvider.notifier).isLoading;

          if (favCarProducts.isEmpty) {
            return Center(
              child: Container(
                margin: const EdgeInsets.only(bottom: 100),
                child: Image.asset(
                  'lib/assets/logo/Add Favorite Items into Wishlist.png',
                  scale: 5,
                ),
              ),
            );
          }

          if (favCarProducts.isEmpty && isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.45,
                  crossAxisSpacing: 5),
              itemCount: favCarProducts.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailsScreen(
                              carProduct: favCarProducts[index],
                              index: index,
                            ),
                          ));
                    },
                    child: ProductCard(
                      carProduct: favCarProducts[index],
                      index: index,
                      onShowHeartIcon: true,
                    ));
              },
            ),
          );
        },
      ),
    );
  }

  // Functions
}
