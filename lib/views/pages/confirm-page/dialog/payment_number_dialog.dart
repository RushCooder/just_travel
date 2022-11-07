import 'package:flutter/material.dart';
import 'package:just_travel/views/widgets/custom_form_field.dart';

 Future<String?> paymentNumberDialog(BuildContext context) {
  final phoneEditingController = TextEditingController();
  return showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Payment'),
      content: CustomFormField(
        controller: phoneEditingController,
        labelText: 'Mobile number',
        hintText: '+8801xxxxxxxxx',
        isPrefIcon: false,
        textInputType: TextInputType.number,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context, phoneEditingController.text.trim());
          },
          child: const Text('Submit'),
        ),
      ],
    ),
  );
}
