import 'package:flutter/material.dart';

void displayResult(BuildContext context, String? message, String resp) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: const Color(0xffffffff),
          elevation: 0,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                resp == 'Ok'
                    ? Icons.check_circle_outlined
                    : Icons.cancel_outlined,
                color: resp == 'Ok'
                    ? const Color(0xff70d404)
                    : const Color(0xfffc1414),
                size: 150.0,
              ),
              const SizedBox(height: 30),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: resp == 'Ok'
                      ? const Color(0xff70d404)
                      : const Color(0xfffc1414),
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: [
            resp == 'Ok'
                ? const _BackToMenuButton()
                : const _CancelAlertButton()
          ],
        ),
      );
    },
  );
}

class _CancelAlertButton extends StatelessWidget {
  const _CancelAlertButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        fixedSize:
            MaterialStateProperty.resolveWith((states) => const Size(150, 48)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => const Color(0xfffc1414)),
      ),
      onPressed: () => Navigator.pop(context),
      child: const Text('Volver'),
    );
  }
}

class _BackToMenuButton extends StatelessWidget {
  const _BackToMenuButton();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        fixedSize:
            MaterialStateProperty.resolveWith((states) => const Size(150, 48)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => const Color(0xff70d404)),
      ),
      onPressed: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, 'home_screen', (route) => false);
      },
      child: const Text('Aceptar'),
    );
  }
}
