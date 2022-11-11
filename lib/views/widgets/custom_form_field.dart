import 'package:flutter/material.dart';
import 'package:just_travel/utils/email_validation.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth_provider.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  bool isPassword;
  bool isPrefIcon;
  int maxLine;
  IconData? icon;
  TextInputType textInputType;
  final String labelText;
  VoidCallback? onEditingComplete;
  String? hintText;
  bool isEmail;
  int? maxLength;
  CustomFormField({
    required this.controller,
    this.icon,
    required this.labelText,
    this.onEditingComplete,
    this.isPassword = false,
    this.isPrefIcon = true,
    this.hintText,
    this.isEmail = false,
    this.textInputType = TextInputType.text,
    this.maxLine = 1,
    this.maxLength,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) => TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        maxLines: maxLine,
        maxLength: maxLength,
        keyboardType: textInputType,
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          filled: true,
          labelText: labelText,
          prefixIcon: isPrefIcon ? Icon(icon) : null,
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: authProvider.changeVisibility,
                  icon: authProvider.isVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : null,
        ),
        obscureText: isPassword ? authProvider.isObscure : false,
        validator: (value) {
          if (isEmail) {
            if (!emailValidation(value!)) {
              return 'Please use a valid Email';
            }
          }
          if (value == null || value.isEmpty) {
            return 'This field must not be empty';
          }
          return null;
        },
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}
