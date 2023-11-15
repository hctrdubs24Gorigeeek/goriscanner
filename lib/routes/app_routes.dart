import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/screens/screens.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getAppRoutes() {
    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll(
      {
        'home_screen': (_) => const HomeScreen(),
        'affiliate_pay_qr_screen': (_) => const AffiliatePayQrScreen(),
        'payment-summary-screen': (_) => const PaymentSummaryScreen(),
        'apecify-amount-screen': (_) => const SpecifyAmountScreen(),
        'pay_qr_menu_screen': (_) => const QrPayMenuScreen(),
        'pay_qr_screen': (_) => const QrPayScreen(),
        'barcode_pay_screen': (_) => const BarcodePayScreen(),
        'pay_scanqr_screen': (_) => const PayScanqrScreen(),
        'affiliate-recharge-balance': (_) =>
            const RechargeBalanceAffiliateScreen(),
        'validate-ticket-screen': (_) => const ValidateTicketScannerScreen(),
      },
    );
    return appRoutes;
  }
}
