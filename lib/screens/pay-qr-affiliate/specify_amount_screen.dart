import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goripay_qr_scanner/screens/screens.dart';
import 'package:provider/provider.dart';
import '../../providers/provider.dart';
import '../../theme/app_theme.dart';

class SpecifyAmountScreen extends StatelessWidget {
  const SpecifyAmountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      appBar: _appBar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: deviceHeight * 0.04,
              left: deviceWidth * 0.12,
              right: deviceWidth * 0.12),
          child: Column(
            children: [
              const Text(
                'Cantidad a pagar',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: deviceHeight * 0.06,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Amount(amount: '\$50.00'),
                  _Amount(amount: '\$100.00'),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.04,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Amount(amount: '\$200.00'),
                  _Amount(amount: '\$500.00'),
                ],
              ),
              SizedBox(
                height: deviceHeight * 0.04,
              ),
              const _Amount(amount: '\$1000.00'),
              SizedBox(
                height: deviceHeight * 0.1,
              ),
              const _OtherImport(),
            ],
          ),
        ),
      ),
    ));
  }
}

class _Button extends StatelessWidget {
  const _Button({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final specifyAmountProvider = Provider.of<SpecifyAmountProvider>(context);
    final double deviceWidth = MediaQuery.of(context).size.width;
    return MaterialButton(
      onPressed: () {
        if (specifyAmountProvider.formKey.currentState?.validate() == true) {
          Navigator.pushNamed(context, 'pay_qr_menu_screen');
        }
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: AppTheme.primaryColor)),
      color: const Color(0xffc66722),
      child: Container(
        width: deviceWidth * 0.80,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: const Center(
          child: Text(
                'Continuar',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class _OtherImport extends StatelessWidget {
  const _OtherImport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final specifyAmountProvider = Provider.of<SpecifyAmountProvider>(context);       
    final double deviceHeight = MediaQuery.of(context).size.height;
    return Form(
        key: specifyAmountProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 20),
                  labelText: 'Otro importe',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 5.0),
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {
                if (double.tryParse(value) != null) {
                  //TODO: cambiar 9999999 por el limite permitido
                  if (double.parse(value) <= 999999) {
                    specifyAmountProvider.amount = double.parse(value);
                  }
                }
              },
              validator: (value) {
                String pattern = r"^\d+(\.\d{1,2})?$";
                RegExp regExp = RegExp(pattern);
                if (value!.isEmpty) {
                  return 'La cantidad no puede quedar vacia';
                }
                if (!regExp.hasMatch(value)) {
                  return 'La cantidad es invalida';
                }             
                if (double.parse(value) > 1000000) {
                  return 'El límite es de XXXXXXX';
                }
                return null;
              },
            ),
            SizedBox(
              height: deviceHeight * 0.05,
            ),
            const _Button()
          ],
        ));
  }
}

class _Amount extends StatelessWidget {
  const  _Amount({super.key, required this.amount});

  final String amount;

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;    
    final specifyAmountProvider = Provider.of<SpecifyAmountProvider>(context);
    return MaterialButton(
      onPressed: () {
        double parsedAmount = double.parse(amount.substring(1));
        String formattedAmount = parsedAmount.toStringAsFixed(2);
        specifyAmountProvider.amount = double.parse(formattedAmount);        
        Navigator.pushNamed(context, 'pay_qr_menu_screen');        
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppTheme.primaryColor, width: 0.5)),
      color: const Color.fromARGB(255, 251, 237, 237),
      child: Container(
        width: deviceWidth * 0.22,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Center(
          child: Text(
            amount,            
            style: const TextStyle(color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: const Icon(Icons.menu, size: 30),      
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      ),
    ),
    title: const Text(
      'Pagar con',
    ),
    // flexibleSpace: Container(
    //   decoration: const BoxDecoration(
    //     image: DecorationImage(
    //       image: AssetImage('assets/images/appbar/app-bar-image.png'),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    // ),
  );
}
