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
        'affiliate-recharge-balance': (_) =>
            const RechargeBalanceAffiliateScreen(),
      },
    );
    return appRoutes;
  }
}
