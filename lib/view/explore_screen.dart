import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:doctor_appointment/models/userModel.dart';
import 'package:doctor_appointment/res/texts/app_text.dart';
import 'package:doctor_appointment/res/widgets/exploreDoctor.dart';
import 'package:doctor_appointment/viewModel/doctor_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../res/widgets/coloors.dart';
import '../utils/List_Helper.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController searchController = TextEditingController();
  bool _isSearching = false;

  void _toggleSearch() {
    final doctorViewModel = context.read<DoctorViewModel>();
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        searchController.clear();
        doctorViewModel.updateSearchQuery('');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final doctorViewModel = context.read<DoctorViewModel>();
      doctorViewModel.getAllDoctors(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final doctorViewModel = context.watch<DoctorViewModel>();

    // Handle search query change
    void onSearchChanged(String query) {
      doctorViewModel.updateSearchQuery(query);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Top Specialist"),
        automaticallyImplyLeading: false,
        actions: [
          _isSearching
              ? Container(
            width: 250,
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
            ),
            child: TextField(
              controller: searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                suffixIcon: IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: _toggleSearch,
                ),
              ),
              onChanged: onSearchChanged,
            ),
          )
              : Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: _toggleSearch,
              icon: Icon(Icons.search),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: doctorViewModel.categories.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final category = doctorViewModel.categories[index];
                  final isSelected =
                  doctorViewModel.selectedCategories.contains(category);
                  return Center(
                    child: InkWell(
                      onTap: () {
                        doctorViewModel.toggleCategory(category);
                      },
                      splashColor: Colors.transparent,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.white,
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '  $category  ',
                          style: AppTextStyle.caption.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.02),
            if (doctorViewModel.loading)
              CircularProgressIndicator()
            else if (doctorViewModel.topDoctors.isEmpty)
              Center(child: Text("No doctors found"))
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: doctorViewModel.topDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = doctorViewModel.topDoctors[index];
                  return DoctorCard(
                    height: height,
                    width: width,
                    doctor: doctor,
                    onMakeAppointment: () {
                      context.push('/doctorMain/${doctor.id}');
                    },
                  );
                },
              ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}


