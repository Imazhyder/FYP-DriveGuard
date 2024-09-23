import 'package:bro/data/List.dart';
import 'package:bro/providers/productsProvider.dart';
import 'package:bro/screens/CartScreen.dart';
import 'package:bro/screens/Categories.dart';
import 'package:bro/screens/productdetails.dart';
import 'package:bro/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ref.read(productsProvider.notifier).fetchProducts();

    // ref.watch(carProvider.notifier).getAllCars();
    // ref.read(favProductProvider.notifier).getFavProducts();

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 100,
          title: Image.asset(
              "lib/assets/logo/WhatsApp_Image_2024-05-05_at_1.09.14_PM-removebg-preview.png",
              scale: 4),
          centerTitle: true,
          leadingWidth: 70,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: CircleAvatar(
                radius: 30,
                backgroundColor:
                    const Color.fromARGB(255, 158, 158, 158).withOpacity(0.1),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartScreen(),
                        ));
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 27,
                  ),
                ),
              ),
            ),
          ],
          // leading: CircleAvatar(
          //   backgroundColor:
          //       const Color.fromARGB(255, 158, 158, 158).withOpacity(0.1),
          //   child: IconButton(
          //       onPressed: () {},
          //       icon: const Icon(
          //         Icons.list,
          //         size: 27,
          //       )),
          // ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hello',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Text(
                  'Welcome To DriveGuard',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: Colors.grey),
                ),
                const Gap(20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //       foregroundColor: Colors.black.withOpacity(0.4),
                    //       textStyle: const TextStyle(
                    //           fontWeight: FontWeight.w400, fontSize: 16)),
                    //   onPressed: () {},
                    //   child: const Text("View all"),
                    // )
                  ],
                ),
                const Gap(10),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                      itemCount: list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoriesScreen(
                                    category: list[index],
                                  ),
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              width: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey.withOpacity(0.1)),
                              child: Center(
                                  child: Text(
                                list[index],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              )),
                            ),
                          ),
                        );
                      }),
                ),
                const Gap(10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "All Products",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //       foregroundColor: Colors.black.withOpacity(0.4),
                    //       textStyle: const TextStyle(
                    //           fontWeight: FontWeight.w400, fontSize: 16)),
                    //   onPressed: () {},
                    //   child: const Text("View all"),
                    // )
                  ],
                ),
                const Gap(10),
                Consumer(
                  builder: (context, ref, child) {
                    final products = ref.watch(productsProvider);

                    if (ref.read(productsProvider.notifier).isLoading) {
                      return const CircularProgressIndicator();
                    }

                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.40,
                              crossAxisSpacing: 5),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                  carProduct: products[index],
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: ProductCard(
                            carProduct: products[index],
                            index: index,
                            onShowHeartIcon: true,
                          ),
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
