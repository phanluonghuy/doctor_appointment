import "package:doctor_appointment/res/widgets/coloors.dart";
import "package:doctor_appointment/res/widgets/profile_tab.dart";
import "package:doctor_appointment/viewModel/user_viewmodel.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:phone_form_field/phone_form_field.dart";
import "package:provider/provider.dart";

import "../../res/texts/app_text.dart";
import "../../res/widgets/buttons/primaryButton.dart";
import "../../res/widgets/datePicker.dart";
import "../../utils/regex.dart";
import "../../utils/utils.dart";
import "../../viewModel/signup_viewmodel.dart";
import "../res/widgets/buttons/backButton.dart";

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ValueNotifier<bool> _obsecureNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecureNotifier1 = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecureNotifier2 = ValueNotifier<bool>(true);

  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final FocusNode _currentPasswordFocusNode = FocusNode();
  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Password Manager"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: CustomBackButton(
            onPressed: () {
              context.pop();
            },
          ),
        ),
        leadingWidth: width * 0.2,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(alignment: Alignment.centerLeft, child: Text("Current Password")),
                  SizedBox(height: height * 0.01),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obsecureNotifier,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _currentPasswordController,
                        focusNode: _currentPasswordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: value,
                        onFieldSubmitted: (value) {
                          Utils.changeNodeFocus(context,
                              current: _currentPasswordFocusNode, next: _newPasswordFocusNode);
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon:
                            Icon(value ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              _obsecureNotifier.value = !_obsecureNotifier.value;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  Align(alignment: Alignment.topRight, child: TextButton(onPressed: () {}, child: Text("Forgot Password?",style: AppTextStyle.linkButton,))),
                  Align(alignment: Alignment.centerLeft, child: Text("New Password")),
                  SizedBox(height: height * 0.01),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obsecureNotifier1,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _newPasswordController,
                        focusNode: _newPasswordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: value,
                        onFieldSubmitted: (value) {
                          Utils.changeNodeFocus(context,
                              current: _newPasswordFocusNode, next: _confirmPasswordFocusNode);
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon:
                            Icon(value ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              _obsecureNotifier1.value = !_obsecureNotifier1.value;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.01),
                  Align(alignment: Alignment.centerLeft, child: Text("New Password")),
                  SizedBox(height: height * 0.01),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obsecureNotifier2,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: value,
                        onFieldSubmitted: (value) {
                          Utils.changeNodeFocus(context,
                              current: _confirmPasswordFocusNode, next: null);
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon:
                            Icon(value ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              _obsecureNotifier2.value = !_obsecureNotifier2.value;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: PrimaryButton(
          text: "Change Password",
          loading: context.watch<UserViewModel>().isLoading,
          onPressed: () {
            if (_currentPasswordController.text.isEmpty) {
              Utils.flushBarErrorMessage('Current password must provide', context);
              return;
            }
            if (AppRegex.isValidPassword(_currentPasswordController.text) == false) {
              Utils.flushBarErrorMessage('Current password must has 1 Lower, 1 Upper, 1 Number, 1 Symbols', context);
              return;
            }
            if (_newPasswordController.text.isEmpty) {
              Utils.flushBarErrorMessage('New password must provide', context);
              return;
            }
            if (AppRegex.isValidPassword(_newPasswordController.text) == false) {
              Utils.flushBarErrorMessage('New password must has 1 Lower, 1 Upper, 1 Number, 1 Symbols', context);
              return;
            }
            if (_confirmPasswordController.text.isEmpty) {
              Utils.flushBarErrorMessage('Confirm password must provide', context);
              return;
            }
            if (_newPasswordController.text != _confirmPasswordController.text) {
              Utils.flushBarErrorMessage('New password and confirm password must be same', context);
              return;
            }
            Map<String,dynamic> data = {
              "currentPassword": _currentPasswordController.text,
              "newPassword": _newPasswordController.text,
            };
            context.read<UserViewModel>().changePassword(data, context);
          },
          context: context,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _currentPasswordFocusNode.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
  }
}
