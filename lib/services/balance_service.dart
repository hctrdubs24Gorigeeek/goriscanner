import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class BalanceService extends ChangeNotifier {
  final String _baseUrl = AppContants.url;
  bool isLoading = false;

  Future payBalanceAffiliateStore(String rawData) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(
      _baseUrl,
      '/public/pay-balance-afilliate-store',
      {'encryptPayQrBodyRequest': rawData},
    );

    try {
      final resp = await http.post(url);

      final responseData =
          json.decode(utf8.decode(resp.bodyBytes, allowMalformed: true));

      isLoading = false;
      notifyListeners();
      return responseData['message'];
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return 'Error with the service';
    }
  }
}
