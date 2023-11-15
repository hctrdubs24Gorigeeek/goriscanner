import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class TicketService extends ChangeNotifier {
  final String _baseUrl = AppContants.url;
  bool isLoading = false;
  bool isValidating = false;

  Future registerTickets(String rawData) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.http(_baseUrl, '/public/register-tickets-afilliate-store',
        {'encryptPayQrBodyRequest': rawData});

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

  Future validateTickets(String scannedData) async {
    isValidating = true;
    notifyListeners();

    final url = Uri.http(
        _baseUrl, '/public/validate-tickets-scanner', {'folio': scannedData});

    try {
      final resp = await http.post(url);

      final responseData =
          json.decode(utf8.decode(resp.bodyBytes, allowMalformed: true));

      isValidating = false;
      notifyListeners();
      return responseData['message'];
    } catch (e) {
      isValidating = false;
      notifyListeners();
      return 'Error with the service';
    }
  }
}
