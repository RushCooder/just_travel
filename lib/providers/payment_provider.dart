import 'package:flutter/material.dart';
import 'package:just_travel/apis/payment_api.dart';

import '../models/db-models/payment_model.dart';

class PaymentProvider extends ChangeNotifier{
  // make payment
  Future<bool> makePayment(PaymentModel paymentModel) async{
    return await PaymentApi.makePayment(paymentModel);

  }
}