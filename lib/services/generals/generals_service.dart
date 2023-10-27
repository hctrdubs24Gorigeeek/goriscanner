import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GeneralsService{
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
}
