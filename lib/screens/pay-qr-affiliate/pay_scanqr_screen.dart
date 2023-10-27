import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/widgets/alerts/push_replacement_remove_until_alert.dart';
import 'dart:io';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../../providers/provider.dart';
import '../../services/services.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alerts/alerts.dart';
import '../../widgets/widgets.dart';

class PayScanqrScreen extends StatelessWidget {
  const PayScanqrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ShowScanBar(
      title: 'Pagar con Código QR',
      description: 'Escanea el Código que te proporcionen',
      child: _Child(),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child({super.key});

  @override
  Widget build(BuildContext context) {
    final specifyAmountProvider = Provider.of<SpecifyAmountProvider>(context);    
    final qrPayService = Provider.of<QrPayService>(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    final qrService = Provider.of<QrPayService>(context);
    return Stack(
      children: [
        (qrService.isSaving == false)
            ? MobileScanner(
                // fit: BoxFit.contain,
                controller: MobileScannerController(
                    detectionSpeed: DetectionSpeed.normal,
                    detectionTimeoutMs: 1000,
                    facing: CameraFacing.back,
                    torchEnabled: false),
                onDetect: (capture) {
                  final List<Barcode> barcodes = capture.barcodes;                  
                  for (final barcode in barcodes) {
                    if (barcode.rawValue != null &&
                        qrPayService.isUsed == false) {
                      qrService
                          .payQr(
                              barcode.rawValue!, specifyAmountProvider.amount)
                          .then((resp) {
                        if (resp['message'] == 'SUCCESS') {
                          _successModal(context);
                        } else {
                          if (resp['message'] == 'BAD_REQUEST') {
                            _errorModal(context,
                                  message: "El Código QR");
                            Future.delayed(const Duration(seconds: 4), () {
                              qrService.isUsed = false;
                            });
                          } else if (resp['message'] == 'UNAUTHORIZED') {                                                                           
                            print("jwt CADUCADO");
                          } else {
                            _errorModal(context);
                            Future.delayed(const Duration(seconds: 4), () {
                              qrService.isUsed = false;
                            });
                          }
                        }
                      });
                    }
                  }
                })
            : Container(
                color: Colors.white,
              ),
        (qrService.isSaving == false)
            ? QRScannerOverlayCustom(
                borderColor: AppTheme.primaryColor,
                borderLength: 10,
                scanAreaSize: Size(deviceWidth * 0.7, deviceWidth * 0.7),
              )
            : const Center(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(
                      strokeWidth: 6,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppTheme.primaryColor)),
                ),
              )
      ],
    );
  }

  void _errorModal(BuildContext context, {String? message}) {
    Platform.isAndroid
        ? displayDialogAndroid(
            context,
            message ?? "Error, revisa tu conexión",
            'error',
            'home_screen',
            null,
            null)
        : displayDialogIOS(
            context,
            message ?? "Error, revisa tu conexión",
            'error',
            'home_screen',
            null,
            null);
  }

  void _successModal(BuildContext context, {String? message}) {
    displayDialogAndroidRemoveUntil(
        context,
        message ?? "El pago fue exitoso",
        'fromQrBar',
        'home_screen',
        '', null, null);
  }
}
