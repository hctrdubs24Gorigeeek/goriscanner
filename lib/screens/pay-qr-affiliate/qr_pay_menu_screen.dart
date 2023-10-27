import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/provider.dart';
import '../../services/services.dart';
import '../../theme/app_theme.dart';
import '../screens.dart';

class QrPayMenuScreen extends StatelessWidget {
  const QrPayMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: deviceWidth * 0.9,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                _TextDescription(deviceWidth: deviceWidth),                              
                const SizedBox(
                  height: 20,
                ),
                const _Amount(),
                const SizedBox(
                  height: 20,
                ),
                  const _OptionToPay(
                    image: 'generateqr.png',
                    text: 'Generar QR',
                    value: 1),
                const _OptionToPay(
                  image: 'generatebar.png',
                  text: 'Generar Código de Barras',
                  value: 2,
                ),
                const _OptionToPay(
                  image: 'scanqr.png',
                  text:
                      'Escanear código',
                  value: 3,
                ),
                const SizedBox(
                  height: 40,
                ),
                const _Buttons()
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, size: 30),
        // TODO: Redirigir a Perfíl.
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        'Pagar con',
      )
    );
  }
}

class _OptionToPay extends StatelessWidget {
  final String image;
  final String text;
  final int value;
  const _OptionToPay({
    super.key,
    required this.image,
    required this.text,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final payQrMenuProvider = Provider.of<QrPayMenuProvider>(context);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              width: 35,
              height: 30,
              child: Image(
                image: AssetImage('assets/images/payqr/$image'),
                fit: BoxFit.cover, // Adjust the image fit as needed
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: const TextStyle(fontSize: 16, height: 1),
                    ),
                    SizedBox(
                      width: 50,
                      height: 12,
                      child: Radio<int>(
                        activeColor: AppTheme.primaryColor,
                        value: value,
                        groupValue: payQrMenuProvider.option,
                        onChanged: (value) {
                          payQrMenuProvider.option = value!;
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        const Divider()
      ],
    );
  }
}

class _TextDescription extends StatelessWidget {
  const _TextDescription({
    super.key,
    required this.deviceWidth,
  });

  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: deviceWidth * 0.7,
      child: const Text(
        'Genera tu código de barras, código QR o escanea',
        style: TextStyle(
          fontSize: 16,
          color: Colors.black54,
          letterSpacing: 1.2,
        ),
        overflow: TextOverflow.fade,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class _Amount extends StatelessWidget {
  const _Amount({super.key});

  @override
  Widget build(BuildContext context) {    
    final payQrMenuProvider = Provider.of<QrPayMenuProvider>(context);
    final specifyAmountProvider = Provider.of<SpecifyAmountProvider>(context);
    const hintTextStyle = TextStyle(color: Color.fromARGB(255, 97, 80, 78));
    final amount =
        '\$${specifyAmountProvider.amount.toStringAsFixed(2)}';
    return Form(
      key: payQrMenuProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(left: 15, bottom: 8),
            child: const Text(
              'Cantidad a cobrar',
              style: TextStyle(color: Colors.black54),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            initialValue: amount.toString(),
            enabled: false,
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xffe8e4e4),
              hintText:
                  'Ingresa la cantidad a cobrar',
              hintStyle: hintTextStyle,
            ),           
          )
        ],
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final payQrMenuProvider = Provider.of<QrPayMenuProvider>(context);
    final qrPayService = Provider.of<QrPayService>(context);    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MaterialButton(
          onPressed: () {
            payQrMenuProvider.emptyFields();            
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false,
            );            
          },
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: AppTheme.primaryColor)),
          color: Colors.white,
          child: Container(
            width: deviceWidth * 0.34,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: const Center(
              child: Text(
                'Cancelar',
                style: TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
              ),
            ),
          ),
        ),
        MaterialButton(
          onPressed: () async {
            GeneralsService.hideKeyboard(context);
            qrPayService.isUsed = false;
            if (!payQrMenuProvider.isValid()) return;
            if (payQrMenuProvider.option == 1) {
              Navigator.pushNamed(context, 'pay_qr_screen');
            } else if (payQrMenuProvider.option == 2) {
              qrPayService.emptyFields();
              Navigator.pushNamed(context, 'barcode_pay_screen');
            } else if (payQrMenuProvider.option == 3) {
              Navigator.pushNamed(context, 'pay_scanqr_screen');
            }
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: AppTheme.primaryColor,
          child: Container(
            width: deviceWidth * 0.34,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: (payQrMenuProvider.isSaving)
                  ? const SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white)),
                    )
                  : const Text(
                      'Confirmar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
            ),
          ),
        )
      ],
    );
  }
}
