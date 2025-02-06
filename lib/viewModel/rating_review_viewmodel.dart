import 'package:flutter/material.dart';

import '../repository/rating_review_repository.dart';
import '../utils/utils.dart';

class RatingReviewViewmodel with ChangeNotifier {
  final _repo = RatingReviewRepository();

  Future<void> addRatingReview(dynamic data, BuildContext context) async {
    try {
      await _repo.addRatingReview(data);
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    }
  }

  Future<void> getRatingReviews(String doctorId, BuildContext context) async {
    try {
      await _repo.getRatingReviews(doctorId);
    } catch (error) {
      Utils.flushBarErrorMessage(error.toString(), context);
      print(error);
    }
  }
}