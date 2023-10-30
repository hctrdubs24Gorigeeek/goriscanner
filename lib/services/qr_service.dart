import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/models/payment_model.dart';
import 'package:goripay_qr_scanner/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class QrService extends ChangeNotifier {
  bool isValidating = false;
  final String _baseUrl = AppContants.url;
  PaymentModel? payment;

  Future valdiateAffiliateQr(String scannedValue) async {
    isValidating = true;
    notifyListeners();

    bool isBase64 = await isBase64Text(scannedValue);

    if (!isBase64) {
      isValidating = false;
      notifyListeners();
      return 'The code is not a payment QR';
    }

    try {
      final url = Uri.http(_baseUrl, '/public/pay-afilliate-store',
          {'encryptPayQrRequest': scannedValue});

      print(url);

      final resp =
          await http.post(url, headers: {"Content-Type": "application/json"});

      final responseData =
          json.decode(utf8.decode(resp.bodyBytes, allowMalformed: true));

      payment = PaymentModel.fromMap(responseData);

      isValidating = false;
      notifyListeners();
      return payment!.message;
    } catch (e) {
      isValidating = false;
      notifyListeners();
      return 'Error while Scanning QR';
    }
  }

  // * Validar QR para recargar balance.
  Future valdiateAffiliateRechargeBalance(String scannedValue) async {
    isValidating = true;
    notifyListeners();

    bool isBase64 = await isBase64Text(scannedValue);

    if (!isBase64) {
      isValidating = false;
      notifyListeners();
      return 'The code is not a payment QR';
    }

    try {
      final url = Uri.http(_baseUrl, '/public/recharge-balance-afilliate-store',
          {'encryptPayQrRequest': scannedValue});

      final resp =
          await http.post(url, headers: {"Content-Type": "application/json"});

      final responseData =
          json.decode(utf8.decode(resp.bodyBytes, allowMalformed: true));

      payment = PaymentModel.fromMap(responseData);

      isValidating = false;
      notifyListeners();
      return payment!.message;
    } catch (e) {
      isValidating = false;
      notifyListeners();
      return 'Error while Scanning QR';
    }
  }

  Future<bool> isBase64Text(String texto) async {
    try {
      encrypt.Encrypted.fromBase64(texto);
      return true;
    } catch (e) {
      return false;
    }
  }
}
