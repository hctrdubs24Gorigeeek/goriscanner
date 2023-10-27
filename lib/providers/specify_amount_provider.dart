import 'package:flutter/material.dart';

class SpecifyAmountProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  double _amount = 0.0;
  double get amount => _amount;

  set amount(double value) {
    _amount = value;
  }
}
