import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:doctor_appointment/models/doctorModel.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../texts/app_text.dart';
import 'coloors.dart';

class DoctorInfo extends StatelessWidget {
  final double height;
  final double width;
  final String name;
  final String address;
  final String url;
  final List<String> specializations;

  const DoctorInfo({
    super.key,
    required this.height,
    required this.width,
    required this.name,
    required this.address,
    required this.specializations,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Stack(
                    children: [
                      CachedNetworkImage(
                        imageUrl: url,
                        imageBuilder: (context, imageProvider) => Container(
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(
                          Icons.person,
                          size: height * 0.08,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      Positioned(
                          right: 0,
                          bottom: height * 0.02,
                          child: Icon(Icons.verified,
                              color: AppColors.primaryColor,
                              size: height * 0.04)),
                    ],
                  ),
                  SizedBox(width: width * 0.04),
                  Expanded(
                    // Wrap this Column in an Expanded widget
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: height * 0.01),
                        Text(
                          "Dr. $name",
                          style: AppTextStyle.body
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: height * 0.01),
                        Wrap(
                          children: [
                            Text(specializations.map((e) => e).join(", "),
                                style: AppTextStyle.caption),
                          ],
                        ),
                        SizedBox(height: height * 0.01),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: AppColors.primaryColor,
                            ),
                            SizedBox(
                              width: width * 0.4,
                              child: Text(
                                address,
                                style: AppTextStyle.caption,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.map_rounded,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
