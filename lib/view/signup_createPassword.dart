import "package:doctor_appointment/res/widgets/coloors.dart";
import "package:flutter/material.dart";
import "package:doctor_appointment/utils/routes/routes_names.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:phone_form_field/phone_form_field.dart";
import "package:provider/provider.dart";

import "../res/texts/app_text.dart";
import "../res/widgets/buttons/primaryButton.dart";
import "../res/widgets/buttons/round_button.dart";
import "../utils/regex.dart";
import "../utils/utils.dart";
import "../viewModel/signup_viewmodel.dart";

class SignUpCreatePasswordScreen extends StatefulWidget {
  const SignUpCreatePasswordScreen({super.key});

  @override
  State<SignUpCreatePasswordScreen> createState() => _SignUpCreatePasswordScreenState();
}

class _SignUpCreatePasswordScreenState extends State<SignUpCreatePasswordScreen> {
  final ValueNotifier<bool> _obsecureNotifier = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _obsecure2Notifier = ValueNotifier<bool>(true);


  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String _phoneNumber = '';
  late bool _isFemale;

  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _genderFocus = FocusNode();
  final bool mobileOnly = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final signupviewmodel = Provider.of<SignUpViewModel>(context);
    PhoneNumberInputValidator? _getValidator(BuildContext context) {
      List<PhoneNumberInputValidator> validators = [];
      if (mobileOnly) {
        validators.add(PhoneValidator.validMobile(context));
      } else {
        validators.add(PhoneValidator.valid(context));
      }
      return validators.isNotEmpty ? PhoneValidator.compose(validators) : null;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.03),
                  Text("Complete Your Profile", style: AppTextStyle.title),
                  SizedBox(height: height * 0.01),
                  Text(
                      "Don't worry, only you can see your personal \n data. No one else will be able to see it.",
                      textAlign: TextAlign.center),
                  SizedBox(height: height * 0.05),
                  Center(child: Stack(children: [
                    CircleAvatar(
                      radius: height * 0.08,
                      backgroundColor: Colors.grey.shade300,
                      child: Icon(Icons.person, size: height * 0.08,color: Colors.grey.shade800),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: height * 0.04, // Diameter of the CircleAvatar + border
                        height: height * 0.04,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white, // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: CircleAvatar(
                          radius: height * 0.03,
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            Icons.edit_rounded,
                            size: height * 0.02,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],)),
                  Align(alignment: Alignment.centerLeft, child: Text("Password")),
                  SizedBox(height: height * 0.01),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obsecureNotifier,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: value,
                        onFieldSubmitted: (value) {
                          Utils.changeNodeFocus(context,
                              current: _passwordFocus, next: _passwordFocus);
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
                  SizedBox(height: height * 0.02),
                  Align(alignment: Alignment.centerLeft, child: Text("Confirm Password")),
                  SizedBox(height: height * 0.01),
                  ValueListenableBuilder<bool>(
                    valueListenable: _obsecure2Notifier,
                    builder: (context, value, child) {
                      return TextFormField(
                        controller: _confirmPasswordController,
                        focusNode: _confirmPasswordFocus,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: value,
                        onFieldSubmitted: (value) {
                          Utils.changeNodeFocus(context,
                              current: _confirmPasswordFocus, next: _phoneFocus);
                        },
                        decoration: InputDecoration(
                          hintText: "Enter your confirm password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffixIcon: IconButton(
                            icon:
                            Icon(value ? Icons.visibility_off : Icons.visibility),
                            onPressed: () {
                              _obsecure2Notifier.value = !_obsecure2Notifier.value;
                            },
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: height * 0.03),
                  PhoneFormField(
                  initialValue: PhoneNumber.parse('+84'), // or use the controller
                  validator: _getValidator(context),
                  focusNode: _phoneFocus,
                  onSubmitted: (phoneNumber) {
                    Utils.changeNodeFocus(context,
                        current: _phoneFocus, next: _genderFocus);
                    _phoneNumber = phoneNumber.countryCode+phoneNumber.nsn;
                  },
                  onChanged: (phoneNumber) {
                    _phoneNumber = phoneNumber.countryCode+phoneNumber.nsn;
                  },
                  enabled: true,
                  isCountrySelectionEnabled: true,
                  isCountryButtonPersistent: true,
                  countryButtonStyle: const CountryButtonStyle(
                      showDialCode: true,
                      showIsoCode: true,
                      showFlag: false,
                  ),
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                    // hintText: 'EYour number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                  SizedBox(height: height * 0.02),
                  Align(alignment: Alignment.centerLeft, child: Text("Gender")),
                  SizedBox(height: height * 0.01),
                  DropdownMenu(
                    hintText: "Select Your Gender",
                   focusNode: _genderFocus,
                   width: double.infinity,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                        label: "Male",
                        value: "male",  // The value to store or process
                      ),
                      DropdownMenuEntry(
                        label: "Female",
                        value: "female",  // The value to store or process
                      ),
                    ],
                    onSelected: (value) {
                      // Handle the selected value
                      if (value == "female") {
                        _isFemale = true;
                      } else {
                        _isFemale = false;
                      }
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  PrimaryButton(
                      text: "Complete Profile",
                      loading: signupviewmodel.loading,
                      onPressed: () {
                        if (_passwordController.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              "Password must be provide", context);
                          return;
                        }

                        if (_confirmPasswordController.text.isEmpty) {
                          Utils.flushBarErrorMessage(
                              "Password must be provide", context);
                          return;
                        }

                        if (_passwordController.text != _confirmPasswordController.text) {
                          Utils.flushBarErrorMessage(
                              "Password must be match", context);
                          return;
                        }
                        print(_phoneNumber);
                        if (AppRegex.isValidPhone(_phoneNumber) == false) {
                          Utils.flushBarErrorMessage(
                              "Phone number must be valid", context);
                          return;
                        }

                        if (_isFemale == null) {
                          Utils.flushBarErrorMessage(
                              "Select one gender", context);
                          return;
                        }

                        print(signupviewmodel.email + signupviewmodel.name + signupviewmodel.password + signupviewmodel.phoneNumber + signupviewmodel.getIsFemale.toString());


                        //
                        // if (AppRegex.isValidEmail(_passwordController.text) == false) {
                        //   Utils.flushBarErrorMessage(
                        //       "Email must be valid", context);
                        //   return;
                        // }
                        //
                        // if (signupviewmodel.termsAccepted == false) {
                        //   Utils.flushBarErrorMessage(
                        //       "You must accept the terms and conditions", context);
                        //   return;
                        // }
                        // signupviewmodel.setName(_confirmPasswordController.text);
                        // signupviewmodel.setEmail(_passwordController.text);
                        // final data = {
                        //   "email": _passwordController.text,
                        // };
                        // signupviewmodel.apiSendOTP(data, context);
                        // context.go('/otp');
                        // context.push('/otp');

                      },
                      context: context),
                  SizedBox(height: height * 0.02),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _passwordFocus.dispose();
  }
}

