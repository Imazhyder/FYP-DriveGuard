import 'package:bro/providers/productsProvider.dart';
import 'package:bro/screens/productdetails.dart';
import 'package:bro/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesScreen extends ConsumerStatefulWidget {
  CategoriesScreen({super.key, required this.category});
  String category;

  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    var listofproducts = ref.read(productsProvider);
    var filteredproducts = listofproducts
        .where((element) => element.category == widget.category)
        .toList();
    print(filteredproducts);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: SafeArea(
          child: GridView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 0.47, crossAxisSpacing: 5),
            itemCount: filteredproducts.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        carProduct: filteredproducts[index],
                        index: index,
                      ),
                    ),
                  );
                },
                child: ProductCard(
                  carProduct: filteredproducts[index],
                  index: index,
                  onShowHeartIcon: true,
                ),
              );
            },
          ),
        ));
  }
}
