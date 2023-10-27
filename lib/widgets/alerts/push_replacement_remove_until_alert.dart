import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goripay_qr_scanner/screens/screens.dart';

void displayDialogAndroidRemoveUntil(
    BuildContext context,
    String message,
    String type,
    String route,
    String arguments,
    String? errorMessageButton,
    String? successMessageButton) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: const Color(0xffffffff),
          elevation: 5,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                type == 'error'
                    ? Icons.cancel_outlined
                    : Icons.check_circle_outlined,
                color: type == 'error'
                    ? const Color(0xfffc1414)
                    : const Color(0xff70d404),
                size: 150.0,
              ),
              const SizedBox(height: 30),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: type == 'error'
                      ? const Color(0xfffc1414)
                      : const Color(0xff70d404),
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: [
            _AlertButtonRemoveUntil(type, route, arguments, errorMessageButton,
                successMessageButton)
          ],
        ),
      );
    },
  );
}

void displayDialogIOSRemoveUntil(
    BuildContext context,
    String message,
    String type,
    String route,
    String arguments,
    String? errorMessageButton,
    String? successMessageButton) {
  showCupertinoDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: const Color(0xffffffff),
          elevation: 5,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                type == 'error'
                    ? Icons.cancel_outlined
                    : Icons.check_circle_outlined,
                color: type == 'error'
                    ? const Color(0xfffc1414)
                    : const Color(0xff70d404),
                size: 150.0,
              ),
              const SizedBox(height: 30),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: type == 'error'
                      ? const Color(0xfffc1414)
                      : const Color(0xff70d404),
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: [
            _AlertButtonRemoveUntil(type, route, arguments, errorMessageButton,
                successMessageButton)
          ],
        ),
      );
    },
  );
}

void displayDialogAndroidPushReplacement(
    BuildContext context,
    String message,
    String type,
    String route,
    String arguments,
    String? errorMessageButton,
    String? successMessageButton) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: const Color(0xffffffff),
          elevation: 5,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                type == 'error'
                    ? Icons.cancel_outlined
                    : Icons.check_circle_outlined,
                color: type == 'error'
                    ? const Color(0xfffc1414)
                    : const Color(0xff70d404),
                size: 150.0,
              ),
              const SizedBox(height: 30),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: type == 'error'
                      ? const Color(0xfffc1414)
                      : const Color(0xff70d404),
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: [
            _AlertButtonPushReplacement(type, route, arguments,
                errorMessageButton, successMessageButton)
          ],
        ),
      );
    },
  );
}

void displayDialogIOSPushReplacement(
    BuildContext context,
    String message,
    String type,
    String route,
    String arguments,
    String? errorMessageButton,
    String? successMessageButton) {
  showCupertinoDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: const Color(0xffffffff),
          elevation: 5,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(5)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                type == 'error'
                    ? Icons.cancel_outlined
                    : Icons.check_circle_outlined,
                color: type == 'error'
                    ? const Color(0xfffc1414)
                    : const Color(0xff70d404),
                size: 150.0,
              ),
              const SizedBox(height: 30),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: type == 'error'
                      ? const Color(0xfffc1414)
                      : const Color(0xff70d404),
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          actions: [
            _AlertButtonPushReplacement(type, route, arguments,
                errorMessageButton, successMessageButton)
          ],
        ),
      );
    },
  );
}

// * Botón para alertas con una acción
class _AlertButtonRemoveUntil extends StatelessWidget {
  final String type;
  final String route;
  final String? errorMessageButton;
  final String? successMessageButton;
  final String? arguments;
  const _AlertButtonRemoveUntil(this.type, this.route, this.arguments,
      this.errorMessageButton, this.successMessageButton);

  @override
  Widget build(BuildContext context) {         
    return TextButton(
      style: ButtonStyle(
        fixedSize:
            MaterialStateProperty.resolveWith((states) => const Size(300, 48)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => type == 'error'
              ? const Color(0xfffc1414)
              : const Color(0xff70d404),
        ),
      ),
      onPressed: () {
        if (type == 'error' || type == 'fromIneValidation') {
          Navigator.of(context).pop(true);
          Navigator.pushReplacementNamed(
            context,
            route,
            arguments: arguments,
          );
        } else if(type == 'fromQrBar'){          
          Navigator.of(context).pop(true);          
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );
        }else{
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (Route<dynamic> route) => false,
          );
        }
      },
      child: type == 'error'
          ? Text(errorMessageButton ??
              'Cerrar')
          : Text(successMessageButton ??
              'Aceptar'),
    );
  }
}

class _AlertButtonPushReplacement extends StatelessWidget {
  final String type;
  final String route;
  final String? errorMessageButton;
  final String? successMessageButton;
  final String? arguments;
  const _AlertButtonPushReplacement(this.type, this.route, this.arguments,
      this.errorMessageButton, this.successMessageButton);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        fixedSize:
            MaterialStateProperty.resolveWith((states) => const Size(300, 48)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        ),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        backgroundColor: MaterialStateColor.resolveWith(
          (states) => type == 'error'
              ? const Color(0xfffc1414)
              : const Color(0xff70d404),
        ),
      ),
      onPressed: () {
        if (type == 'error') {
          Navigator.pop(context);
        } else {
          Navigator.of(context).pop(true);
          Navigator.pushReplacementNamed(
            context,
            route,
            arguments: arguments,
          );
        }
      },
      child: type == 'error'
          ? Text(errorMessageButton ??
              'Cerrar')
          : Text(successMessageButton ??
              'Aceptar'),
    );
  }
}

