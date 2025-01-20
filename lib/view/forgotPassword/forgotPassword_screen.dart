import "package:doctor_appointment/res/widgets/coloors.dart";
import "package:doctor_appointment/res/widgets/profile_tab.dart";
import "package:doctor_appointment/viewModel/user_viewmodel.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:go_router/go_router.dart";
import "package:phone_form_field/phone_form_field.dart";
import "package:pin_code_fields/pin_code_fields.dart";
import "package:provider/provider.dart";

import "../../../res/texts/app_text.dart";
import "../../../res/widgets/buttons/primaryButton.dart";
import "../../../res/widgets/datePicker.dart";
import "../../../utils/regex.dart";
import "../../../utils/utils.dart";
import "../../../viewModel/signup_viewmodel.dart";
import "../../res/widgets/buttons/backButton.dart";
import "../../viewModel/forgorPassword_viewmodel.dart";
import "forgotPwChange_screen.dart";
import "forgotPwGetEmail_screen.dart";
import "forgotPwGetOTP_screen.dart";
import "forgotPwSuccess_screen.dart";

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ForgotPasswordViewModel(this), // Pass TickerProvider here
      builder: (context, _) {
        return ForgotPasswordContent(); // Child widget to separate UI logic
      },
    );
  }
}

class ForgotPasswordContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel =
        Provider.of<ForgotPasswordViewModel>(context, listen: true);
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: viewModel.pageController,
        onPageChanged: viewModel.handlePageViewChanged,
        children: <Widget>[
          GetEmail(),
          GetOTP(),
          ChangePassWord(),
          ChangePasswordSuccess(),
        ],
      ),
    );
  }
}


