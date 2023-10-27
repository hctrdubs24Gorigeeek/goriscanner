import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:encrypt/encrypt.dart' as encrypt;
import '../../utils/app_constants.dart';
import '../../interceptors/http_client_interceptor.dart';
import '../../widgets/alerts/push_replacement_remove_until_alert.dart';

class QrPayService extends ChangeNotifier {
  final String _baseUrl = AppContants.url;
  final HttpClientInterceptor _httpClientInterceptor = HttpClientInterceptor();
  //IMPORTANTE:   Key de 32 bytes
  static final key = encrypt.Key.fromBase64(AppContants.key);
  //IMPORTANTE:   IV de 16 bytes
  static final iv = encrypt.IV.fromBase64(AppContants.iv);
  //Consultar documentación para cambiar encriptado
  static final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  bool _isSaving = false;
  bool _isUsed = false;
  BuildContext? _context;  
  bool get isUsed => _isUsed;
  set isUsed(bool value) {
    _isUsed = value;
    notifyListeners();
  }

  bool get isSaving => _isSaving;
  set isSaving(bool value) {
    _isSaving = value;
    notifyListeners();
  }

  Future<Map<String, dynamic>> encryptAES(amount, folio, context) async {
    String data = '{"folio": "$folio"}';    
    _context = context;
    final encrypted = encrypter.encrypt(data.toString(), iv: iv);
    Map<String, dynamic> resp = await registerQr(folio, amount);
    if (resp['message'] != 'UNAUTHORIZED' && resp['message'] != null) {
      resp['message'] = encrypted.base64;
    } else if (resp['message'] == null) {
      _errorModal(_context!);
    }
    return resp;
  }

  Future<bool> esTextoBase64(String texto) async {
    try {
      encrypt.Encrypted.fromBase64(texto);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map<String, dynamic>> payQr(String scannedText, double amount) async {
    //true si es qr. false si es bar
    bool barOrQr = await esTextoBase64(scannedText);
    String encryptedText = '';
    if (barOrQr == false) {
      String data = '{"folio": "$scannedText"}';
      encryptedText = await encryptText(data);
    } else {
      encryptedText = scannedText;
    }
    int idUser = 337;
    String data =
        '{"idUsuario": $idUser,"encryptedText": "$encryptedText", "monto":$amount}';
    Map<String, dynamic> response = {'message': null};
    Map<String, dynamic> requestBody = {
      'encryptedText': await encryptText(data)
    };
    isSaving = true;
    final url = Uri.http(_baseUrl, 'pay-qr-terminal');
    final request = http.Request('POST', url)
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(requestBody);
    final resp = await _httpClientInterceptor.intercept(request);
    if (resp.statusCode == 200) {
      isUsed = true;
      isSaving = false;
      response['message'] = 'SUCCESS';
    } else if (resp.statusCode == 400) {
      isUsed = true;
      isSaving = false;
      response['message'] = 'BAD_REQUEST';
    } else if (resp.statusCode == 401) {
      isUsed = true;
      isSaving = false;
      response['message'] = 'UNAUTHORIZED';      
    }
    isUsed = true;
    isSaving = false;
    return response;
  }

  Future<String> encryptText(String data) async {
    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  Future<Map<String, dynamic>> registerQr(String folio, double amount) async {
    int idUser = 337;
    Map<String, dynamic> response = {'message': null};
    Map<String, dynamic> requestBody = {
      'idUsuario': {'idUsuario': idUser},
      'folio': folio,
      'monto': amount
    };
    final url = Uri.http(_baseUrl, 'register-qr');
    final request = http.Request('POST', url)
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode(requestBody);
    final resp = await _httpClientInterceptor.intercept(request);
    if (resp.statusCode == 200) {
      final decodeData = json.decode(utf8.decode(resp.bodyBytes));
      response['message'] = decodeData['message'];
      return response;
    } else if (resp.statusCode == 401) {
      response['message'] = 'UNAUTHORIZED';
      return response;
    }
    return response;
  }

  void emptyFields() {
    _isSaving = false;
    _isUsed = false;
    _context = null;    
  }

  void _errorModal(BuildContext context, {String? message}) {     
    Platform.isAndroid
        ? displayDialogAndroidRemoveUntil(
            context,
            message ?? 'Error, revisa tu conexión',
            'error',
            'home_screen',
            '',
            null,
            null)
        : displayDialogIOSRemoveUntil(
            context,
            message ?? 'Error, revisa tu conexión',
            'error',
            'home_screen',
            '',
            null,
            null);
  }
}