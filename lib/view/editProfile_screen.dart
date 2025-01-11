import "package:doctor_appointment/res/widgets/coloors.dart";
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

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isInitialized = false;

  String _phoneNumber = '';
  late bool _isFemale;

  final FocusNode _nameFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _genderFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();
  final bool mobileOnly = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!_isInitialized) {
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      _nameController.text = userViewModel.user?.name ?? '';
      _addressController.text = userViewModel.user?.address ?? '';
      _isInitialized = true;
    }

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userViewModel = Provider.of<UserViewModel>(context);

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
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: CustomBackButton(
            onPressed: () {
              context.pop(); // This will navigate to the 'Bookings' screen
            },
          ),
        ),
        leadingWidth: width*0.2,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  Align(alignment: Alignment.centerLeft, child: Text("Name")),
                  SizedBox(height: height * 0.01),
                  TextFormField(
                    controller: _nameController,
                    focusNode: _nameFocus,
                    keyboardType: TextInputType.name,
                    onFieldSubmitted: (value) {
                      Utils.changeNodeFocus(context,
                          current: _nameFocus, next: _phoneFocus);
                      userViewModel.user?.name = value;
                    },
                    onChanged: (value) {
                      userViewModel.user?.name = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Align(alignment: Alignment.centerLeft, child: Text("Phone Number")),
                  SizedBox(height: height * 0.01),
                  PhoneFormField(
                    initialValue: PhoneNumber.parse('+${userViewModel.user?.phone}'), // or use the controller
                    validator: _getValidator(context),
                    focusNode: _phoneFocus,
                    onSubmitted: (phoneNumber) {
                      Utils.changeNodeFocus(context,
                          current: _phoneFocus, next: _genderFocus);
                      _phoneNumber = phoneNumber.countryCode+phoneNumber.nsn;
                      userViewModel.user?.phone = _phoneNumber;
                    },
                    onChanged: (phoneNumber) {
                      _phoneNumber = phoneNumber.countryCode+phoneNumber.nsn;
                      userViewModel.user?.phone = _phoneNumber;
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
                    initialSelection: (userViewModel.user?.gender ?? false)? "male" : "female",
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
                      userViewModel.user?.gender = _isFemale;
                      Utils.changeNodeFocus(context,
                          current: _genderFocus, next: _addressFocus);
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  Align(alignment: Alignment.centerLeft, child: Text("Address")),
                  SizedBox(height: height * 0.01),
                  TextFormField(
                    controller: _addressController,
                    focusNode: _addressFocus,
                    keyboardType: TextInputType.streetAddress,
                    onFieldSubmitted: (value) {
                      Utils.changeNodeFocus(context,
                          current: _addressFocus, next: null);
                      // signupviewmodel.address = _addressController.text;
                      userViewModel.user?.address = value;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter your address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Align(alignment: Alignment.centerLeft, child: Text("Your Date of Birth")),
                  SizedBox(height: height * 0.01),
                  DatePicker(
                    initialDate: userViewModel.user?.dateOfBirth ?? DateTime.now(),
                    onDateChanged: (DateTime selectedDate) {
                      if (userViewModel.user != null) {
                        userViewModel.user!.dateOfBirth = selectedDate; // Use '!' after null check
                      }
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  PrimaryButton(
                      text: "Update Profile",
                      loading: userViewModel.isLoading,
                      onPressed: () {
                        if (userViewModel.user?.name == null) {
                          Utils.flushBarErrorMessage(
                              "Name must be provided", context);
                          return;
                        }

                        if (AppRegex.isValidPhone(userViewModel.user?.phone ?? "") == false) {
                          Utils.flushBarErrorMessage(
                              "Phone number must be valid", context);
                          return;
                        }

                        if (userViewModel.user?.gender == null) {
                          Utils.flushBarErrorMessage(
                              "Select one gender", context);
                          return;
                        }

                        if (userViewModel.user?.address == null) {
                          Utils.flushBarErrorMessage(
                              "Address must be provide", context);
                          return;
                        }

                        Map<String,dynamic> data = {
                          "name" : userViewModel.user?.name,
                          "phone": userViewModel.user?.phone,
                          "dateOfBirth" : userViewModel.user?.dateOfBirth.toString(),
                          "isFemale" : userViewModel.user?.gender,
                          "address" : userViewModel.user?.address,
                        };
                        // print(data);
                        userViewModel.apiUpdateProfile(data, context);

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
  }
}

