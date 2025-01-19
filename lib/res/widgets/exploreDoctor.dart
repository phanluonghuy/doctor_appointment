import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:doctor_appointment/models/doctorModel.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../texts/app_text.dart';
import 'coloors.dart';

class DoctorCard extends StatelessWidget {
  final double height;
  final double width;
  final Doctor doctor;
  final VoidCallback onMakeAppointment;

  const DoctorCard({
    super.key,
    required this.height,
    required this.width,
    required this.doctor,
    required this.onMakeAppointment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: doctor.avatar.url,
                      imageBuilder: (context, imageProvider) => Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.person,
                          size: height * 0.08, color: Colors.grey.shade800),
                    ),
                    SizedBox(width: width * 0.04),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.lightPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.verified,
                                color: AppColors.primaryColor,
                              ),
                              Text("  Professional",
                                  style: AppTextStyle.caption.copyWith(
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text("Dr. ${doctor.name}", style: AppTextStyle.body),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Wrap(
                          children: [
                            Text(
                                doctor.specializations
                                    .map((e) => e.specializations)
                                    .join(", "),
                                style: AppTextStyle.caption)
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        // TODO: Fix the experience years
                        Text(
                            "Experience: ${(doctor.specializations.isNotEmpty) ? doctor.specializations[0].experienceYears : "0"} years",
                            style: AppTextStyle.caption),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize
                              .min, // Shrinks the Row to fit its children
                          children: [
                            RatingBar.readOnly(
                              filledIcon: Icons.star,
                              emptyIcon: Icons.star_border,
                              halfFilledIcon: Icons.star_half,
                              isHalfAllowed: true,
                              initialRating: doctor.averageRating,
                              maxRating: 5,
                              size: 16,
                            ),
                            SizedBox(
                                height: 12,
                                child: VerticalDivider(color: Colors.grey)),
                            Text(
                              "${doctor.totalReviews} Reviews",
                              style: AppTextStyle.caption,
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(height: height * 0.01),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.lightPrimaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                height: 50,
                width: double.infinity,
                child: MaterialButton(
                  onPressed: onMakeAppointment,
                  child: Center(
                    child: Text(
                      'Make Appointment',
                      style: const TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
