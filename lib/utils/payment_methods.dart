import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sslcommerz/model/SSLCCustomerInfoInitializer.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_travel/models/db-models/user_model.dart';
import 'package:random_string/random_string.dart';

class PaymentMethods {
  // generating random transaction id
  final String _tranId = randomAlphaNumeric(
    10,
    provider: CoreRandomProvider.from(
      Random.secure(),
    ),
  ).toUpperCase();

  Future<SSLCTransactionInfoModel?> sslCommerzGeneralCall({
    required String phoneNumber,
    required double amount,
    required UserModel user,
  }) async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //Use the ipn if you have valid one, or it will fail the transaction.
        // ipn_url: "www.ipnurl.com",
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Travel",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: 'justt6367570a84491',
        store_passwd: 'justt6367570a84491@ssl',
        total_amount: amount,
        tran_id: _tranId,
      ),
    );

    sslcommerz.addCustomerInfoInitializer(
      customerInfoInitializer: SSLCCustomerInfoInitializer(
        customerState: user.division ?? 'null',
        customerName: user.name ?? 'null',
        customerEmail: user.email?.emailId ?? 'null',
        customerAddress1: '${user.division} ${user.district}',
        customerCity: user.district ?? "null",
        customerPostCode: "1200",
        customerCountry: "Bangladesh",
        customerPhone: phoneNumber,
      ),
    );

    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      if (result.status!.toLowerCase() == "failed") {
        Fluttertoast.showToast(
          msg: "Transaction is Failed....",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return null;
      } else if (result.status!.toLowerCase() == "closed") {
        Fluttertoast.showToast(
          msg: "SDK Closed by User",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        return null;
      } else {
        Fluttertoast.showToast(
          msg: "Transaction is ${result.status} and Amount is ${result.amount}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        return result;
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  // Future<void> sslCommerzCustomizedCall() async {
  //   Sslcommerz sslcommerz = Sslcommerz(
  //     initializer: SSLCommerzInitialization(
  //       //Use the ipn if you have valid one, or it will fail the transaction.
  //       // ipn_url: "www.ipnurl.com",
  //       multi_card_name: "visa,master,bkash",
  //       currency: SSLCurrencyType.BDT,
  //       product_category: "Food",
  //       sdkType: SSLCSdkType.TESTBOX,
  //       store_id: 'justt6367570a84491',
  //       store_passwd: 'justt6367570a84491@ssl',
  //       total_amount: 10,
  //       tran_id: "1231321321321312",
  //     ),
  //   );
  //
  //   sslcommerz.addCustomerInfoInitializer(
  //     customerInfoInitializer: SSLCCustomerInfoInitializer(
  //       customerState: "Chattogram",
  //       customerName: "Abu Sayed Chowdhury",
  //       customerEmail: "sayem227@gmail.com",
  //       customerAddress1: "Anderkilla",
  //       customerCity: "Chattogram",
  //       customerPostCode: "200",
  //       customerCountry: "Bangladesh",
  //       customerPhone: 'phone',
  //     ),
  //   );
  //
  //   try {
  //     SSLCTransactionInfoModel result = await sslcommerz.payNow();
  //
  //     if (result.status!.toLowerCase() == "failed") {
  //       Fluttertoast.showToast(
  //           msg: "Transaction is Failed....",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.CENTER,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     } else {
  //       Fluttertoast.showToast(
  //         msg: "Transaction is ${result.status} and Amount is ${result.amount}",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0,
  //       );
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
