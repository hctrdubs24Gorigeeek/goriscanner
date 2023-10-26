import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/providers/provider.dart';
import 'package:goripay_qr_scanner/services/services.dart';
import 'package:goripay_qr_scanner/widgets/display_results.dart';
import 'package:provider/provider.dart';

class PaymentSummaryScreen extends StatelessWidget {
  const PaymentSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final qrService = Provider.of<QrService>(context);

    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 30),
            child: const Text('Datos de cobro',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
          _SummaryDataContainer(
              title: 'Cantidad', data: '\$ ${qrService.payment!.amount}'),
          _SummaryDataContainer(
              title: 'Comisión', data: '\$ ${qrService.payment!.fee}'),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: const Text('Total a cobrar',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          ),
          _SummaryDataContainer(
              title: '', data: '\$ ${qrService.payment!.total}'),
          const SizedBox(
            height: 30,
          ),
          const _ActionsButtons()
        ],
      ),
    );
  }
}

class _SummaryDataContainer extends StatelessWidget {
  const _SummaryDataContainer({
    required this.data,
    required this.title,
  });
  final String data;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40, bottom: 5),
            child: Text(
              title,
              style: const TextStyle(color: Color(0xff666666), fontSize: 16),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            height: 60,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Color(0xffededed),
            ),
            child: Text(data, style: const TextStyle(fontSize: 20)),
          ),
        ],
      ),
    );
  }
}

class _ActionsButtons extends StatelessWidget {
  const _ActionsButtons();

  @override
  Widget build(BuildContext context) {
    final ticketService = Provider.of<TicketService>(context);
    final balanceService = Provider.of<BalanceService>(context);
    final affiliateQrProvider = Provider.of<AffilliateQrProvider>(context);

    return SizedBox(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                side: MaterialStateBorderSide.resolveWith(
                  (_) => const BorderSide(color: Color(0xffC66722), width: 2),
                ),
                foregroundColor: MaterialStateColor.resolveWith(
                  (_) => const Color(0xffC66722),
                ),
                backgroundColor:
                    MaterialStateColor.resolveWith((_) => Colors.white),
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: () =>
                  Navigator.pushReplacementNamed(context, 'home_screen'),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                      (_) => const Color(0xffdb6424)),
                  foregroundColor:
                      MaterialStateColor.resolveWith((_) => Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                onPressed: ticketService.isLoading
                    ? null
                    : () {
                        if (affiliateQrProvider.rechargeBalance) {
                          balanceService
                              .payBalanceAffiliateStore(
                                  affiliateQrProvider.rawData)
                              .then((resp) {
                            switch (resp) {
                              case 'Error creating tickets':
                                displayResult(
                                    context, 'Error al procesar pago', resp);
                                break;
                              case 'The qr code does not exist':
                                displayResult(
                                    context, 'Sin datos del cliente', resp);
                                break;
                              case 'Ok':
                                displayResult(context, 'Pago realizado', resp);
                                break;
                              default:
                            }
                          });

                          affiliateQrProvider.rechargeBalance = false;
                        } else {
                          ticketService
                              .registerTickets(affiliateQrProvider.rawData)
                              .then((resp) {
                            switch (resp) {
                              case 'Error creating tickets':
                                displayResult(
                                    context, 'Error al procesar pago', resp);
                                break;
                              case 'The qr code does not exist':
                                displayResult(
                                    context, 'Sin datos del cliente', resp);
                                break;
                              case 'Ok':
                                displayResult(context, 'Pago realizado', resp);
                                break;
                              default:
                            }
                          });
                        }
                      },
                child: ticketService.isLoading
                    ? const SizedBox(
                        height: 10,
                        width: 10,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ))
                    : const Text(
                        'Confirmar pago',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
          ),
        ],
      ),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: const Text(
      'Resumen',
    ),
  );
}
