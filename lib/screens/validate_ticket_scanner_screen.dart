import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/services/services.dart';
import 'package:goripay_qr_scanner/utils/scaffold_keys.dart';
import 'package:goripay_qr_scanner/widgets/display_results.dart';
import 'package:goripay_qr_scanner/widgets/qr_scan_custom_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class ValidateTicketScannerScreen extends StatelessWidget {
  const ValidateTicketScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ticketService = Provider.of<TicketService>(context);
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: ScaffoldKeys.scaffoldkey,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Validar boletos'),
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
                            child: (!ticketService.isValidating)
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
                                          ticketService
                                              .validateTickets(
                                                  barcode.rawValue!)
                                              .then((resp) {
                                            switch (resp) {
                                              case 'TTicker does not exists':
                                                displayResult(
                                                    context,
                                                    'El boleto no está registrado',
                                                    resp);
                                                break;
                                              case 'The ticket has already been changed':
                                                displayResult(
                                                    context,
                                                    'El boleto ya ha sido canjeado',
                                                    resp);
                                                break;
                                              case 'The ticket has already expired':
                                                displayResult(
                                                    context,
                                                    'El boleto ha expirado',
                                                    resp);
                                                break;
                                              case 'Ok':
                                                displayResult(
                                                    context, 'Piola', resp);
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
                        (!ticketService.isValidating)
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
