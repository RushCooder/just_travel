import 'package:flutter/material.dart';
import 'package:just_travel/providers/auth_provider.dart';
import 'package:just_travel/providers/user_provider.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/views/widgets/dialogs/otpp_dialog.dart';
import 'package:just_travel/views/widgets/dialogs/user_image_picker_dialog.dart';
import 'package:just_travel/views/widgets/loading_widget.dart';
import 'package:just_travel/views/widgets/upload_image_card.dart';
import 'package:provider/provider.dart';

import '../../../utils/constants/urls.dart';
import '../custom_form_field.dart';

void contactDialog(BuildContext context) {
  final mobileNumberTextEditingController = TextEditingController();
  final cityTextEditingController = TextEditingController();
  final divisionTextEditingController = TextEditingController();

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
                //current city
                CustomFormField(
                  controller: cityTextEditingController,
                  icon: Icons.location_city,
                  labelText: 'Current City',
                ),
                const SizedBox(
                  height: 30,
                ),
                // current division
                CustomFormField(
                  controller: divisionTextEditingController,
                  icon: Icons.living,
                  labelText: 'Current Division',
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
                context.read<UserProvider>().userImagePath != null) {
              context.read<AuthProvider>().setContactInfo(
                    context.read<UserProvider>().userImagePath!,
                    mobileNumberTextEditingController.text.trim(),
                    cityTextEditingController.text.trim(),
                    divisionTextEditingController.text.trim(),
                  );
              showLoadingDialog(context);
              otpDialog(context, mobileNumberTextEditingController.text.trim());
            }else{
              showMsg(context, 'Please upload image');
            }
          },
          child: const Text('Next'),
        ),
      ],
    ),
  );
}
