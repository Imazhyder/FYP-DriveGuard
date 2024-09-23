import 'package:bro/data/productdata.dart';
import 'package:bro/providers/carsprovider.dart';
import 'package:bro/providers/productsProvider.dart';
import 'package:bro/screens/ModelDetails.dart';
import 'package:bro/screens/productdetails.dart';
import 'package:bro/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  List<CarProduct> searchProducts = [];

  void search(String query, List<CarProduct> products) {
    if (query.isNotEmpty) {
      var filteredProducts = products.where((element) {
        if (query.length == 1) {
          // If the query is a single letter, filter products that start with that letter
          return element.product_name
              .toLowerCase()
              .startsWith(query.toLowerCase());
        } else if (query.toLowerCase() == "oil") {
          // If the query is "oil", filter products that contain "oil"
          return element.product_name.toLowerCase().contains("oil");
        } else if (query.toLowerCase() == "car oil") {
          // If the query is "car oil", filter products that contain "car oil"
          return element.product_name.toLowerCase().contains("car oil");
        } else if (query.toLowerCase() == "oil filters") {
          // If the query is "oil filters", filter products that contain "oil filters"
          return element.product_name.toLowerCase().contains("oil filters");
        } else if (query.toLowerCase() == "air filters") {
          // If the query is "air filters", filter products that contain "air filters"
          return element.product_name.toLowerCase().contains("air filters");
        } else {
          // If the query is more than one letter, filter products that contain the query
          return element.product_name
              .toLowerCase()
              .contains(query.toLowerCase());
        }
      }).toList();

      setState(() {
        searchProducts = filteredProducts;
      });
    } else {
      // If the query is empty, clear the search results
      setState(() {
        searchProducts.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(carProvider.notifier).getAllCars();
    var listOfProducts = ref.read(productsProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Image.asset(
            "lib/assets/logo/WhatsApp_Image_2024-05-05_at_1.09.14_PM-removebg-preview.png",
            scale: 4),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search Products ',
              ),
              onChanged: (value) {
                search(value, listOfProducts);
              },
            ),
          ),
          searchProducts.isEmpty
              ? Consumer(
                  builder: (context, ref, child) {
                    var listOfCars = ref.watch(carProvider);

                    if (ref.watch(carProvider.notifier).isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: listOfCars.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(4),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(listOfCars[index].car_name),
                                  trailing: Icon(Icons.arrow_forward_ios_sharp),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ModelDetailsScreen(
                                            car: listOfCars[index],
                                          ),
                                        ));
                                  },

                                  // You can add onTap handler if needed
                                ),
                                const Divider(
                                  color: Colors.grey,
                                  thickness: 1,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              : Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(20),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.43,
                            crossAxisSpacing: 5),
                    itemCount: searchProducts.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(
                                carProduct: searchProducts[index],
                                index: index,
                              ),
                            ),
                          );
                        },
                        child: ProductCard(
                          carProduct: searchProducts[index],
                          index: index,
                          onShowHeartIcon: true,
                        ),
                      );
                    },
                  ),
                )
        ],
      ),
    );
  }
}
