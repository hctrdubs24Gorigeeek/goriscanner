import 'package:flutter/material.dart';

class QrPayMenuProvider extends ChangeNotifier {
  bool _isSaving = false;
  int _option = 1;  
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get isSaving => _isSaving;

  set isSaving(bool value) {
    _isSaving = value;
    notifyListeners();
  }

  int get option => _option;

  set option(int value) {
    _option = value;
    notifyListeners();
  }
  
  void emptyFields(){    
    isSaving = false;
    option = 1;
  }
  bool isValid() {
    return formKey.currentState?.validate() ?? false;
  }
}
