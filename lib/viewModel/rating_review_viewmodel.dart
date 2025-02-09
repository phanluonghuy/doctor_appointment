import 'package:doctor_appointment/models/reviewModel.dart';
import 'package:flutter/material.dart';

import '../repository/rating_review_repository.dart';
import '../utils/utils.dart';

class RatingReviewViewmodel with ChangeNotifier {
  final _repo = RatingReviewRepository();
  Review? currentReview;
  bool isLoading = false;

  Future<void> addRatingReview(dynamic data, BuildContext context) async {
    try {
      await _repo.addRatingReview(data);
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    }
  }

  Future<void> getRatingReviews(String doctorId, BuildContext context) async {
    isLoading = true;
    notifyListeners();

    await _repo.getRatingReviews(doctorId).then((value) {
      if (value.acknowledgement == true) {
        currentReview = Review.fromJson(value.data);
      } else {
        Utils.flushBarErrorMessage("Error", context);
      }
    }).catchError((error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    });

    isLoading = false;
    notifyListeners();
  }
}
