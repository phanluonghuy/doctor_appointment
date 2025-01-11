import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../res/widgets/coloors.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title:  Row(
          children: [
            Expanded(
              child: SearchBar(
                controller: searchController,
                autoFocus: false,
                enabled: false,
                hintText: 'Search for doctors',
                leading:
                const Icon(Icons.search, color: AppColors.primaryColor),
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 16.0)),
              ),
            ),
            SizedBox(width: width * 0.02),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  border:
                  Border.all(color: AppColors.primaryColor, width: 10),
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              child: InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/buttons/icons8-adjust.svg',
                  fit: BoxFit.contain,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: width * 0.02)
          ],
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(child: Text("Body"),),
    );
  }
}
