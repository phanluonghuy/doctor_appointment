import 'package:doctor_appointment/models/reviewModel.dart';
import 'package:flutter/material.dart';

import '../repository/rating_review_repository.dart';
import '../utils/utils.dart';

class RatingReviewViewmodel with ChangeNotifier {
  final _repo = RatingReviewRepository();
  Review? currentReview;

  Future<void> addRatingReview(dynamic data, BuildContext context) async {
    try {
      await _repo.addRatingReview(data);
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    }
  }

  Future<void> getRatingReviews(String doctorId, BuildContext context) async {
    await _repo.getRatingReviews(doctorId).then((value) {
      if (value.acknowledgement == true) {
        currentReview = Review.fromJson(value.data);
        return;
      }
      Utils.flushBarErrorMessage("Error", context);
    }).onError((error, stackTrace) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    });
    // try {
    //   await _repo.getRatingReviews(doctorId);
    // } catch (error) {
    //   Utils.flushBarErrorMessage(error.toString(), context);
    //   print(error);
    // }
  }
}