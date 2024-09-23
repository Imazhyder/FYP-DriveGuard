import 'package:bro/styles/EditProfiletext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsScreen extends StatelessWidget {
  ReviewsScreen({super.key, required this.reviews});
  List<dynamic> reviews;
  @override
  Widget build(BuildContext context) {
    print(reviews);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: SafeArea(
          child: reviews.isEmpty
              ? const Center(
                  child: Text("No reviews"),
                )
              : ListView.builder(
                  itemCount: reviews.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text(reviews[index]['user_id']['username']),
                      subtitle: Text(reviews[index]['review_Description']),
                      trailing: Column(
                        children: [
                          RatingBar.builder(
                            initialRating: reviews[index]['rating'].toDouble(),
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemSize: 15,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 3),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          Text(
                            "${reviews[index]['rating']}",
                            style: editProfileText,
                          )
                        ],
                      ),
                    );
                  },
                )),
    );
  }
}
