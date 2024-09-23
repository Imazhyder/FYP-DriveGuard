import 'package:bro/data/List.dart';
import 'package:bro/providers/modelpreferences.dart';
import 'package:bro/screens/productdetails.dart';
import 'package:bro/styles/EditProfiletext.dart';
import 'package:bro/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ModelWiseFilteringScreen extends ConsumerStatefulWidget {
  const ModelWiseFilteringScreen(
      {super.key, required this.car_id, required this.model_id});

  final String car_id;
  final String model_id;

  @override
  ConsumerState<ModelWiseFilteringScreen> createState() =>
      _ModelWiseFilteringScreenState();
}

class _ModelWiseFilteringScreenState
    extends ConsumerState<ModelWiseFilteringScreen> {
  String showCategory = "All";

  @override
  void initState() {
    super.initState();
    ref
        .read(modelPreferencesProvider.notifier)
        .fetchPreferedProducts(widget.car_id, widget.model_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtered Products"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Tabs for category selection
              SizedBox(
                height: 60,
                child: ListView.builder(
                  itemCount: list2.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, index) {
                    bool isSelected = showCategory == list2[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showCategory = list2[index];
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: isSelected
                                ? Colors.blue.withOpacity(0.3)
                                : Colors.grey.withOpacity(0.1),
                          ),
                          child: Center(
                            child: Text(
                              list2[index],
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: isSelected ? Colors.blue : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: ref
                      .watch(modelPreferencesProvider.notifier)
                      .fetchPreferedProducts(widget.car_id, widget.model_id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      var listOfOilFilters = ref
                          .read(modelPreferencesProvider.notifier)
                          .listOfOilFilters;
                      var listofAirFilters = ref
                          .read(modelPreferencesProvider.notifier)
                          .listofAirFilters;
                      var listofCarOil = ref
                          .read(modelPreferencesProvider.notifier)
                          .listofCarOil;

                      return SingleChildScrollView(
                        child: SafeArea(
                          child: Column(
                            children: [
                              // Oil Filters
                              if (showCategory == "All" ||
                                  showCategory == "Oil Filter") ...[
                                const Gap(10),
                                Text("Oil filters",
                                    style: modelWiseFilteringScreentext),
                                SizedBox(
                                  height: 400,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    itemCount: listOfOilFilters.length,
                                    itemExtent: 170,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (listOfOilFilters[index]
                                                  .product_id !=
                                              "") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsScreen(
                                                  carProduct:
                                                      listOfOilFilters[index],
                                                  heroTag: 'oilFilter-$index',
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: ProductCard(
                                          carProduct: listOfOilFilters[index],
                                          onShowHeartIcon: true,
                                          heroTag:
                                              'oilFilter-$index', // Unique hero tag
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                              // Air Filters
                              if (showCategory == "All" ||
                                  showCategory == "Air Filter") ...[
                                const Gap(10),
                                Text("Air filters",
                                    style: modelWiseFilteringScreentext),
                                SizedBox(
                                  height: 400,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    itemCount: listofAirFilters.length,
                                    itemExtent: 170,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (listofAirFilters[index]
                                                  .product_name !=
                                              "") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsScreen(
                                                  carProduct:
                                                      listofAirFilters[index],
                                                  heroTag: 'airFilter-$index',
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: ProductCard(
                                          carProduct: listofAirFilters[index],
                                          index: index,
                                          onShowHeartIcon: true,
                                          heroTag:
                                              'airFilter-$index', // Unique hero tag
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                              // Car Oil
                              if (showCategory == "All" ||
                                  showCategory == "Car Oil") ...[
                                const Gap(10),
                                Text("Car Oil",
                                    style: modelWiseFilteringScreentext),
                                SizedBox(
                                  height: 400,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    itemCount: listofCarOil.length,
                                    itemExtent: 170,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          if (listofCarOil[index]
                                                  .product_name !=
                                              "") {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailsScreen(
                                                  carProduct:
                                                      listofCarOil[index],
                                                  heroTag: 'carOil-$index',
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: ProductCard(
                                          carProduct: listofCarOil[index],
                                          index: index,
                                          onShowHeartIcon: true,
                                          heroTag:
                                              'carOil-$index', // Unique hero tag
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
