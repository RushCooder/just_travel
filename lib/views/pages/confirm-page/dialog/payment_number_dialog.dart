import 'package:flutter/material.dart';
import 'package:just_travel/utils/helper_functions.dart';
import 'package:just_travel/utils/mobile_number_operations.dart';
import 'package:just_travel/views/widgets/custom_form_field.dart';

 Future<String?> paymentNumberDialog(BuildContext context) {
  final phoneEditingController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Payment'),
      content: Form(
        key: formKey,
        child: CustomFormField(
          controller: phoneEditingController,
          labelText: 'Mobile number',
          hintText: '+8801xxxxxxxxx',
          isPrefIcon: false,
          textInputType: TextInputType.phone,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate() && validateMobileNumber(phoneEditingController.text.trim())){
              Navigator.pop(context, formatMobileNumber(phoneEditingController.text.trim()));
            }
            else{
              showMsg(context, 'Please enter valid mobile number');
            }
            
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}
