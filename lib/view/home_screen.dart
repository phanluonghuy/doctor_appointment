import 'package:doctor_appointment/viewModel/auth_viewmodel.dart';
import 'package:doctor_appointment/viewModel/signup_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:doctor_appointment/viewModel/user_viewmodel.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final preferences = Provider.of<UserViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
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
