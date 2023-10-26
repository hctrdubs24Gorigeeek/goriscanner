import 'package:flutter/material.dart';

class AffilliateQrProvider extends ChangeNotifier {
  String _rawData = '';
  bool _rechargeBalance = false;

  bool get rechargeBalance => _rechargeBalance;
  set rechargeBalance(bool value) {
    _rechargeBalance = value;
    notifyListeners();
  }

  String get rawData => _rawData;

  set rawData(String value) {
    _rawData = value;
    ChangeNotifier();
  }
}
