bool validateMobileNumber(String mobileNumber) {
  RegExp pattern = RegExp(r'(^(\+88)?(01){1}[3456789]{1}(\d){8})$');
  return pattern.hasMatch(mobileNumber);
}

String formatMobileNumber(String mobileNumber){
  if (mobileNumber.trim()[0] != '+') {
    return '+88${mobileNumber.trim()}';
  }
  return mobileNumber;
}