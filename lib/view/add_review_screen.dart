import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_appointment/res/widgets/buttons/backButton.dart';
import 'package:doctor_appointment/viewModel/doctor_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/doctorModel.dart';
import '../res/texts/app_text.dart';
import '../res/widgets/buttons/primaryButton.dart';
import '../res/widgets/coloors.dart';
import '../viewModel/rating_review_viewmodel.dart';
import '../viewModel/user_viewmodel.dart';

class AddReviewScreen extends StatefulWidget {
  AddReviewScreen({super.key, required this.doctorId});
  String doctorId;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  late Doctor? doctor;
  late int currentRating = 5;
  late String review = "";

  void init() async {
    final doctorViewModel = context.read<DoctorViewModel>();
    doctor = doctorViewModel.doctors
        .firstWhere((doctor) => doctor.id == widget.doctorId);
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

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
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: height * 0.06,
                  backgroundImage:
                      (doctor != null ? doctor!.avatar.url : "").isNotEmpty
                          ? CachedNetworkImageProvider(doctor!.avatar.url)
                          : AssetImage('assets/illustrations/doctor-3d.png')
                              as ImageProvider, // Fallback image
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
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            Text(
              "How was your experience with ${doctor?.name.split(" ").last ?? ""}?",
              style: AppTextStyle.subtitle,
            ),
            Divider(
              height: 5,
              indent: 20,
              endIndent: 20,
              thickness: 0.5,
            ),
            Text(
              "Your overall rating",
              style:
                  TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            RatingBar.builder(
              initialRating: 5,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 10.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                currentRating = rating.toInt();
              },
            ),
            Divider(
              height: 5,
              indent: 20,
              endIndent: 20,
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add detailed review",
                      style: AppTextStyle.subtitle,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          hintText: "Enter here",
                          border: OutlineInputBorder()),
                      maxLines: 5,
                      onChanged: (value) => review = value,
                    )
                  ],
                ),
              ),
            ),
            // Expanded(child: child)
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: PrimaryButton(
          text: "Submit",
          onPressed: () async {
            final ratingReviewViewModel = context.read<RatingReviewViewmodel>();
            final userViewModel = context.read<UserViewModel>();
            Map<String, dynamic> data = {
              "patientId": userViewModel.user!.id,
              "doctorId": widget.doctorId,
              "rating": currentRating,
              "comment": review
            };
            await ratingReviewViewModel.addRatingReview(data, context).then((_) => context.pop());
          },
          context: context,
        ),
      ),

    );
  }
}
