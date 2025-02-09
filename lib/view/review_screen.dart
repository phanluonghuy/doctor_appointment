import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/res/widgets/buttons/backButton.dart';
import 'package:doctor_appointment/viewModel/doctor_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/doctorModel.dart';
import '../models/ratingModel.dart';
import '../res/texts/app_text.dart';
import '../res/widgets/coloors.dart';
import '../viewModel/rating_review_viewmodel.dart';

class ReviewScreen extends StatefulWidget {
  ReviewScreen({super.key, required this.doctorId});
  String doctorId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  late Doctor? doctor;

  void init() async {
    final doctorViewModel = context.read<DoctorViewModel>();
    doctor = doctorViewModel.doctors
        .firstWhere((doctor) => doctor.id == widget.doctorId);
    await context
        .read<RatingReviewViewmodel>()
        .getRatingReviews(widget.doctorId, context);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final ratingViewModel = context.watch<RatingReviewViewmodel>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomBackButton(
            onPressed: () {
              context.pop();
            },
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: ratingViewModel.isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: height * 0.06,
                backgroundImage: (doctor != null ? doctor!.avatar.url : "")
                    .isNotEmpty
                    ? CachedNetworkImageProvider(doctor!.avatar.url)
                    : AssetImage('assets/illustrations/doctor-3d.png')
                as ImageProvider,
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: Icon(Icons.verified_sharp,
                      color: AppColors.primaryColor, size: height * 0.04)),
            ],
          ),
          Text(
            "Dr. ${doctor?.name ?? ""}",
            style: AppTextStyle.subtitle,
          ),
          Text(
            doctor?.specializations.first.specializations
                .join(" ")
                .toString() ??
                "",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 5,
            indent: 20,
            endIndent: 20,
            thickness: 0.5,
          ),
          Text(
            "Overall rating: ${ratingViewModel.currentReview?.averageRating.toStringAsPrecision(3) ?? 0}",
            style: TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold),
          ),
          RatingBar.builder(
            initialRating:
            ((ratingViewModel.currentReview?.averageRating ?? 5) * 2)
                .floor() /
                2,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},

          ),
          Divider(
            height: 5,
            indent: 20,
            endIndent: 20,
            thickness: 0.5,
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                final Rating rating =
                ratingViewModel.currentReview!.ratings[index];
                return ListTile(
                  leading: SizedBox(
                    height: height * 0.05,
                    width: height * 0.05,
                    child: CachedNetworkImage(
                      imageUrl: rating.patientId.avatar?.url ?? "",
                      imageBuilder: (context, imageProvider) =>
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          CircleAvatar(
                            child: Icon(
                              Icons.person,
                              color: Colors.grey.shade800,
                            ),
                          ),
                    ),
                  ),
                  title: Text(
                    rating.patientId.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(rating.comment!),
                  trailing: Text(
                    "⭐ ${rating.rating.toStringAsPrecision(1)}",
                    style: AppTextStyle.subtitle,
                  ),
                );
              },
              itemCount:
              ratingViewModel.currentReview?.ratings.length ?? 0,
            ),
          )
        ],
      ),
    );
  }

}
