import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/routes/app_routes.dart';
import 'package:goripay_qr_scanner/services/services.dart';
import 'package:goripay_qr_scanner/providers/provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => QrService()),
        ChangeNotifierProvider(create: (_) => AffilliateQrProvider()),
        ChangeNotifierProvider(create: (_) => TicketService()),
        ChangeNotifierProvider(create: (_) => BalanceService()),
        ChangeNotifierProvider(create: (_) => SpecifyAmountProvider()),        
        ChangeNotifierProvider(create: (_) => QrPayMenuProvider()),        
        ChangeNotifierProvider(create: (_) => QrPayService()),                                                   
      ], child: const MyApp()),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        theme:
            ThemeData.light().copyWith(primaryColor: const Color(0xffC66722)),
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        routes: AppRoutes.getAppRoutes(),
        initialRoute: 'home_screen',
      ),
    );
  }
}
