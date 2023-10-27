import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:barcode_widget/barcode_widget.dart';
import '../../providers/provider.dart';
import '../../utils/generate_code.dart';
import '../../services/services.dart';
import '../../widgets/widgets.dart';

class BarcodePayScreen extends StatelessWidget {
  const BarcodePayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final qrPayService = Provider.of<QrPayService>(context);
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        qrPayService.emptyFields();
        return false;
      },
      child: const ShowScanBar(
        title: 'Código Barras',
        description:
            'Este es el Código de Barras para pagar en tu establecimiento',
        child: _Child(),
      ),
    );
  }
}

class _Child extends StatelessWidget {
  const _Child({super.key});

  @override
  Widget build(BuildContext context) {
    final qrPayService = Provider.of<QrPayService>(context);
    final specifyAmountProvider = Provider.of<SpecifyAmountProvider>(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    String folio = GenerateCode.generateFolio(2);
    return FutureBuilder(
        future: qrPayService.encryptAES(
            specifyAmountProvider.amount, folio, context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                  width: 40, height: 40, child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final Map<String, dynamic>? resp = snapshot.data;
            if (resp?['message'] == null) {
              return Container();
            } else if (resp!['message'] == 'UNAUTHORIZED') {
              qrPayService.emptyFields();
              return const Text('UNAUTHORIZED');
            }
            return SizedBox(
              height: deviceWidth * 0.6,
              child: Padding(
                padding: const EdgeInsets.only(left: 65, right: 65, top: 40),
                child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: folio,
                ),
              ),
            );
          }
        });
  }
}
