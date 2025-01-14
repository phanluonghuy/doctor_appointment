import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../res/texts/app_text.dart';
import '../../res/widgets/buttons/primaryButton.dart';
import '../../utils/regex.dart';
import '../../utils/utils.dart';
import '../../viewModel/forgorPassword_viewmodel.dart';
import '../../viewModel/user_viewmodel.dart';


class ChangePassWord extends StatefulWidget {
  const ChangePassWord({super.key});

  @override
  State<ChangePassWord> createState() => _ChangePassWordState();
}

class _ChangePassWordState extends State<ChangePassWord>
{
  final ValueNotifier<bool> _obsecureNotifier1 = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecureNotifier2 = ValueNotifier<bool>(true);

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final FocusNode _newPasswordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();


  @override
  dispose() {
    _obsecureNotifier1.dispose();
    _obsecureNotifier2.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _newPasswordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToFocusedWidget() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_newPasswordFocusNode.hasFocus || _confirmPasswordFocusNode.hasFocus) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Provider.of<ForgotPasswordViewModel>(context, listen: false)
                  .previousPage();
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/illustrations/mega-creator (2).svg',
                    height: height * 0.4,
                    fit: BoxFit.scaleDown,
                  ),
                  SizedBox(height: height * 0.03),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Please enter your new password",
                        style:
                        AppTextStyle.body.copyWith(fontWeight: FontWeight.w600),
                      )),
                  SizedBox(height: height * 0.03),
                  Align(
                      alignment: Alignment.centerLeft, child: Text("New Password")),
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
                              current: _newPasswordFocusNode,
                              next: _confirmPasswordFocusNode);
                        },
                        onTap: _scrollToFocusedWidget,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                                value ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              _obsecureNotifier1.value = !_obsecureNotifier1.value;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.01),
                  Align(
                      alignment: Alignment.centerLeft, child: Text("New Password")),
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
                        onTap: _scrollToFocusedWidget,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                                value ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              _obsecureNotifier2.value = !_obsecureNotifier2.value;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  PrimaryButton(
                    text: "Change Password",
                    loading: context.watch<UserViewModel>().isLoading,
                    onPressed: () {
                      if (_newPasswordController.text.isEmpty) {
                        Utils.flushBarErrorMessage('New password must provide', context);
                        return;
                      }
                      if (AppRegex.isValidPassword(_newPasswordController.text) ==
                          false) {
                        Utils.flushBarErrorMessage(
                            'New password must has 1 Lower, 1 Upper, 1 Number, 1 Symbols',
                            context);
                        return;
                      }
                      if (_confirmPasswordController.text.isEmpty) {
                        Utils.flushBarErrorMessage(
                            'Confirm password must provide', context);
                        return;
                      }
                      if (_newPasswordController.text !=
                          _confirmPasswordController.text) {
                        Utils.flushBarErrorMessage(
                            'New password and confirm password must be same', context);
                        return;
                      }
                      Map<String,dynamic> data = {
                        "token": context.read<ForgotPasswordViewModel>().token,
                        "password": _newPasswordController.text,
                      };
                      Provider.of<ForgotPasswordViewModel>(context, listen: false).apiChangePassword(data, context);
                    },
                    context: context,
                  )
                ],
              ),
            )),
      ),
    );
  }
}
