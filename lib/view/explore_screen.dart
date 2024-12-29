import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("ExploreScreen"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
            onTap: () {
              preferences.removeUser().then((value) {
                context.go('/login');
              });
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const NavigationMenu()),
              // );

            },
            child: Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Ink(
                child: const Text("Logout"),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: Center(child: Text("Body"),),
    );
  }
}
