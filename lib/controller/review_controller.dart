import 'package:get/get.dart';
import 'package:travel_directory/database/database_helper.dart';

import '../models/review.dart';

class ReviewController extends GetxController {
  final RxList<Review> rewiews = <Review>[].obs;

  @override
  void onInit() {
    super.onInit();
  }

  void submit(Review review) async {
    await DatabaseHelper().insertReview(review);
    getAllReviews();
  }

  void getAllReviews() async {
    List<Review> reviewList = [];
    var dd = await DatabaseHelper().getReviews();
    dd.forEach((element) {
      reviewList.add(Review.map(element));
    });
    rewiews.value = reviewList;
  }
}
