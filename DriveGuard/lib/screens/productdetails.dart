import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bro/data/CartItemModel.dart';
import 'package:bro/data/productdata.dart';
import 'package:bro/providers/cartprovider.dart';
import 'package:bro/screens/Reviews.dart';
import 'package:bro/screens/bottoNavigation.dart';
import 'package:bro/styles/Light_Text.dart';
import 'package:bro/styles/bold_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  ProductDetailsScreen(
      {super.key, required this.carProduct, this.index, this.heroTag});

  final CarProduct carProduct;
  final int? index;
  final String? heroTag;

  @override
  ConsumerState<ProductDetailsScreen> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends ConsumerState<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var listofcartproducts = ref.watch(cartProvider);
    var isInCart = listofcartproducts
        .any((element) => element.product_id == widget.carProduct.product_id);
    print(isInCart);

    // Debugging: Print imgUrl value
    print('Image URL: ${widget.carProduct.imgUrl}');

    return Scaffold(
      bottomNavigationBar: ElevatedButton(
        onPressed: () {
          var product_id = widget.carProduct.product_id;
          var product_name = widget.carProduct.product_name;
          var price = widget.carProduct.price.toDouble();
          var imgUrl = widget.carProduct.imgUrl;

          ref.read(cartProvider.notifier).addItem(
              context,
              ProductCartItem(
                  product_id: product_id,
                  product_name: product_name,
                  imgUrl: imgUrl,
                  price: price));

          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: const EdgeInsets.fromLTRB(0, 10, 10, 40),
          backgroundColor: const Color.fromRGBO(150, 117, 250, 1),
        ),
        child: Text(isInCart ? "Remove from Cart" : "Add to cart"),
      ),
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.1),
        leadingWidth: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  _showDescriptionDialog();
                },
                icon: const Icon(
                  Icons.edit,
                  size: 27,
                ),
              ),
            ),
          ),
        ],
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                size: 27,
              )),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 100),
                  width: MediaQuery.of(context).size.width *
                      0.8, // 80% of screen width
                  height: MediaQuery.of(context).size.height *
                      0.4, // 40% of screen height
                  child: widget.heroTag != null
                      ? Hero(
                          tag: widget.heroTag!, // Use the provided heroTag
                          child: CachedNetworkImage(
                            imageUrl: widget.carProduct.imgUrl,
                            placeholder: (context, url) => const SizedBox(
                              width: 30,
                              height: 30,
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                      : (widget.index != null
                          ? Hero(
                              tag: widget.index!,
                              child: CachedNetworkImage(
                                imageUrl: widget.carProduct.imgUrl,
                                placeholder: (context, url) => const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.carProduct.imgUrl,
                              placeholder: (context, url) => const SizedBox(
                                width: 30,
                                height: 30,
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )),
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.2,
              maxChildSize: 0.5,
              minChildSize: 0.2,
              builder: (context, controller) {
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white),
                  child: SingleChildScrollView(
                    controller: controller,
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Light_Text(
                                  text: widget.carProduct.category,
                                  fontSize: 15),
                              Light_Text(text: "Price", fontSize: 13)
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: BoldText(
                                    text: widget.carProduct.product_name,
                                    fontSize: 20),
                              ),
                              const Gap(10),
                              BoldText(
                                  text: "\PKR ${widget.carProduct.price}",
                                  fontSize: 20),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: BoldText(text: "Description", fontSize: 17),
                          ),
                          Text(widget.carProduct.description),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BoldText(text: "Reviews", fontSize: 17),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ReviewsScreen(
                                            reviews:
                                                widget.carProduct.reviews ?? [],
                                          ),
                                        ));
                                  },
                                  child: const Text("View all"),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _showDescriptionDialog() {
    String? description;
    double newRating = 4;
    final _formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Your review'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RatingBar.builder(
                  initialRating: 4,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 25,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 3),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    newRating = rating;
                    print(newRating);
                  },
                ),
                const Gap(10),
                TextFormField(
                  minLines: 4,
                  maxLines: null, // Allow unlimited lines
                  decoration: const InputDecoration(
                    hintText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please Enter Description";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    description = newValue;
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                bool isValid = _formKey.currentState!.validate();

                if (!isValid) {
                  return;
                }

                _formKey.currentState!.save();
                await addReview(newRating, description!);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> addReview(double rating, String description) async {
    var product_id = widget.carProduct.product_id;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('user_id').toString();

    var requestBody = {
      'user_id': userid,
      'rating': rating,
      'review_Description': description
    };
    try {
      final response = await http.put(
          Uri.parse('http://localhost:3000/api/add_Review/$product_id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: json.encode(requestBody));

      if (response.statusCode == 200) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          headerAnimationLoop: false,
          animType: AnimType.bottomSlide,
          title: 'Your Review Added',
          buttonsTextStyle: const TextStyle(color: Colors.black),
          showCloseIcon: true,
          btnOkOnPress: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BotttomNavigationScreen(),
                ));
          },
        ).show();
      }
    } catch (error) {
      print(error);

      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        headerAnimationLoop: false,
        animType: AnimType.bottomSlide,
        title: 'Some Error Occured',
        buttonsTextStyle: const TextStyle(color: Colors.black),
        showCloseIcon: true,
        btnOkColor: Colors.red,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
