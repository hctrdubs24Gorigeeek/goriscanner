import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/providers/provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final affilliateQrProvider = Provider.of<AffilliateQrProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('QR Scanner'),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 90,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'validate-ticket-screen');
                },
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: const Text('Tickets'))),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'affiliate_pay_qr_screen');
                },
                child: const Text('Affiliate payment')),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                affilliateQrProvider.rechargeBalance = true;
                Navigator.pushNamed(context, 'affiliate-recharge-balance');
              },
              child: const Text('Affiliate recharge payment'),
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, 'apecify-amount-screen');
              },
              child: const Text('Pay with QR - affiliate'),
            )
          ],
        ),
      ),
    );
  }
}
