import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/constants/urls.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/utils/mobile_number_operations.dart';
import 'package:just_travel/views/pages/auth/signup/components/district_dropdown.dart';
import 'package:just_travel/views/pages/auth/signup/components/division_dropdown.dart';
import 'package:just_travel/views/pages/auth/signup/dialog/otpp_dialog.dart';
import 'package:just_travel/views/widgets/custom_form_field.dart';
import 'package:just_travel/views/widgets/dialogs/user_image_picker_dialog.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:just_travel/views/widgets/upload_image_card.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/districts_provider.dart';

void contactDialog(BuildContext context) {
  final mobileNumberTextEditingController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Text(
        'Add Contact Info',
        style: Theme.of(context).textTheme.headline4,
      ),
      content: SizedBox(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // image card
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) =>
                      userProvider.userImagePath == null
                          ? UploadImageCard(
                              child: Image.asset(
                                'images/img.png',
                                height: 250,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              ),
                              onTap: () {
                                userImagePickerDialog(context);
                              },
                            )
                          : UploadImageCard(
                              child: Consumer<UserProvider>(
                                builder: (context, provider, child) =>
                                    Image.network(
                                  '${baseUrl}uploads/${provider.userImagePath}',
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              onTap: () {
                                userImagePickerDialog(context);
                              },
                            ),
                ),
                const SizedBox(
                  height: 30,
                ),

                // mobile number
                CustomFormField(
                  controller: mobileNumberTextEditingController,
                  icon: Icons.phone,
                  labelText: 'Mobile Number',
                  hintText: '+8801XXXXXXXXX',
                  textInputType: TextInputType.phone,
                ),
                const SizedBox(
                  height: 30,
                ),

                // date of birth
                Row(
                  children: [
                    const Text('Date of Birth'),
                    const SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () async {
                        DateTime? dateTime = await showDatePicker(
                          context: context,
                          initialDate: DateTime(2005),
                          firstDate: DateTime(1950),
                          lastDate: DateTime.now(),
                        );
                        if (dateTime != null) {
                          context
                              .read<AuthProvider>()
                              .setDob(dateTime.millisecondsSinceEpoch);
                        }
                      },
                      child: Consumer<AuthProvider>(
                        builder: (context, authPro, child) => Text(
                          authPro.dob == null
                              ? 'Select Date'
                              : getFormattedDateTime(
                                  dateTime: authPro.dob!,
                                  pattern: 'MMM dd yyyy',
                                ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 5,
                ),
                // gender section
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Gender'),
                    Row(
                      children: [
                        Consumer<AuthProvider>(
                          builder: (context, authPro, child) => Radio<String>(
                            value: 'male',
                            groupValue: authPro.genderGroupValue,
                            onChanged: (value) {
                              authPro.setGenderGroupValue(value!);
                            },
                          ),
                        ),
                        const Text('Male'),
                      ],
                    ),
                    Row(
                      children: [
                        Consumer<AuthProvider>(
                          builder: (context, authPro, child) => Radio<String>(
                            value: 'female',
                            groupValue: authPro.genderGroupValue,
                            onChanged: (value) {
                              authPro.setGenderGroupValue(value!);
                            },
                          ),
                        ),
                        const Text('Female'),
                      ],
                    ),
                  ],
                ),

                //current city
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: DivisionDropDown(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // current division
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: DistrictDropDown(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate() &&
                context.read<UserProvider>().userImagePath != null &&
                context.read<AuthProvider>().dob != null &&
                context.read<AuthProvider>().genderGroupValue != null) {
              showLoadingDialog(context);
              // RegExp pattern = RegExp(r'(^(\+88)?(01){1}[3456789]{1}(\d){8})$');
              //
              // // if ()

              if (validateMobileNumber(
                  mobileNumberTextEditingController.text.trim())) {
                mobileNumberTextEditingController.text = formatMobileNumber(
                    mobileNumberTextEditingController.text.trim());

                final disProvider = context.read<DistrictsProvider>();
                context.read<AuthProvider>().setContactInfo(
                      imagePath: context.read<UserProvider>().userImagePath!,
                      mobileNumber:
                          mobileNumberTextEditingController.text.trim(),
                      division: disProvider.division!.division!,
                      district: disProvider.district!.district!,
                    );
                otpDialog(
                    context, mobileNumberTextEditingController.text.trim());
                // disProvider.reset();
              } else {
                showMsg(context, 'Please enter mobile number');
              }
            } else {
              showMsg(context, 'Empty data can not be submitted');
            }
          },

          // onPressed: () {
          //   RegExp pattern = RegExp(r'(^(\+88)?(01){1}[3456789]{1}(\d){8})$');
          //   if (pattern
          //       .hasMatch(mobileNumberTextEditingController.text.trim())) {
          //     showMsg(context, 'Perfect');
          //   } else {
          //     // ignore: use_build_context_synchronously
          //     showMsg(context, 'Please enter mobile number');
          //   }
          // },
          child: const Text('Next'),
        ),
      ],
    ),
  );
}
