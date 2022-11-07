import 'dart:convert';

import 'package:http/http.dart';
import 'package:just_travel/models/db-models/payment_model.dart';

import '../utils/constants/urls.dart';

class PaymentApi{
  // make payment
  static Future<bool> makePayment(PaymentModel paymentModel) async {
    var headers = {'Content-Type': 'application/json'};
    var request = Request('POST', Uri.parse('${baseUrl}payment'));
    request.body = json.encode(paymentModel.toJson());
    request.headers.addAll(headers);
    try {
      StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        // print(await response.stream.bytesToString());
        return true;
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (e) {
      print('failed because: $e');
      return false;
    }
  }

}