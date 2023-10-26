import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/providers/provider.dart';
import 'package:goripay_qr_scanner/services/qr_service.dart';
import 'package:goripay_qr_scanner/utils/scaffold_keys.dart';
import 'package:goripay_qr_scanner/widgets/display_results.dart';
import 'package:goripay_qr_scanner/widgets/qr_scan_custom_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class RechargeBalanceAffiliateScreen extends StatelessWidget {
  const RechargeBalanceAffiliateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rechargeBalanceQrService = Provider.of<QrService>(context);
    final affiliateQrProvider = Provider.of<AffilliateQrProvider>(context);
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: ScaffoldKeys.scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Escaner Tienda afiliada'),
      ),
      body: Container(
        padding: EdgeInsets.only(bottom: deviceHeight * 0.025),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              fit: FlexFit.loose,
              flex: 4,
              child: SizedBox(
                height: deviceHeight * 0.98,
                child: Column(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.17,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: deviceHeight * 0.55,
                          alignment: Alignment.center,
                          child: SizedBox(
                            child: (!rechargeBalanceQrService.isValidating)
                                ? MobileScanner(
                                    controller: MobileScannerController(
                                        detectionSpeed: DetectionSpeed.normal,
                                        detectionTimeoutMs: 1000,
                                        facing: CameraFacing.back,
                                        torchEnabled: false),
                                    onDetect: (barcodes) {
                                      // final List<Barcode> barcodes = capture.barcodes;

                                      for (final barcode in barcodes.barcodes) {
                                        if (barcode.rawValue != null) {
                                          affiliateQrProvider.rawData =
                                              barcode.rawValue!;

                                          rechargeBalanceQrService
                                              .valdiateAffiliateRechargeBalance(
                                                  barcode.rawValue!)
                                              .then((resp) {
                                            switch (resp) {
                                              case 'The text could not be decoded':
                                                displayResult(
                                                    context,
                                                    'No se pudo completar la acción, contacte al soporte técnico',
                                                    resp);
                                                break;
                                              case 'Invalid QR code':
                                                displayResult(context,
                                                    'El QR es invalido', resp);
                                                break;
                                              case 'The QR code is already expired':
                                                displayResult(
                                                    context,
                                                    'El código ha expirado',
                                                    resp);
                                                break;
                                              case 'The qr code does not exist':
                                                displayResult(
                                                    context,
                                                    'El QR no pertenece a Goripay',
                                                    resp);
                                              case 'The code is not a payment QR':
                                                displayResult(
                                                    context,
                                                    'El QR no contiene datos de pago',
                                                    resp);
                                                break;
                                              case 'Ok':
                                                Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        'payment-summary-screen',
                                                        (route) => false);
                                                break;
                                              default:
                                                return 'Error';
                                            }
                                          });
                                        }
                                      }
                                    },
                                  )
                                : const Center(
                                    child: SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 6,
                                        color: Color(0xffC66722),
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        (!rechargeBalanceQrService.isValidating)
                            ? Container(
                                width: double.infinity,
                                height: deviceHeight * 0.55,
                                alignment: Alignment.center,
                                child: SizedBox(
                                  child: QRScannerOverlayCustom(
                                    borderColor: const Color(0xffC66722),
                                    borderLength: 10,
                                    scanAreaSize: Size(
                                        deviceWidth * 0.7, deviceWidth * 0.7),
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
