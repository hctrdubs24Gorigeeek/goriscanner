import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

// * Alertas con una acción
void displayDialogIOS(
  BuildContext context,
  String message,
  String type,
  String route,
  String? errorMessageButton,
  String? successMessageButton,
) =>
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              type == 'error'
                  ? Icons.cancel_outlined
                  : Icons.check_circle_outlined,
              color: type == 'error'
                  ? AppTheme.dangerColor
                  : AppTheme.successColor,
              size: 150.0,
            ),
            const SizedBox(height: 30),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: type == 'error'
                    ? AppTheme.dangerColor
                    : AppTheme.successColor,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          _AlertButton(type, route, errorMessageButton, successMessageButton)
        ],
      ),
    );

void displayDialogAndroid(
  BuildContext context,
  String message,
  String type,
  String route,
  String? errorMessageButton,
  String? successMessageButton,
) =>
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
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
              type == 'error'
                  ? Icons.cancel_outlined
                  : Icons.check_circle_outlined,
              color: type == 'error'
                  ? AppTheme.dangerColor
                  : AppTheme.successColor,
              size: 150.0,
            ),
            const SizedBox(height: 30),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: type == 'error'
                    ? AppTheme.dangerColor
                    : AppTheme.successColor,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          _AlertButton(type, route, errorMessageButton, successMessageButton)
        ],
      ),
    );

// * Botón para alertas con una acción
class _AlertButton extends StatelessWidget {
  final String type;
  final String route;
  final String? errorMessageButton;
  final String? successMessageButton;

  const _AlertButton(
    this.type,
    this.route,
    this.errorMessageButton,
    this.successMessageButton,
  );

  @override
  Widget build(BuildContext context) => TextButton(
        style: ButtonStyle(
          fixedSize:
              MaterialStateProperty.resolveWith((_) => const Size(300, 48)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          foregroundColor: MaterialStateColor.resolveWith((_) => Colors.white),
          backgroundColor: MaterialStateColor.resolveWith(
            (_) =>
                type == 'error' ? AppTheme.dangerColor : AppTheme.successColor,
          ),
        ),
        onPressed: () => type == 'error' || type == 'noRedirect'
            ? Navigator.pop(context)
            : Navigator.popUntil(context, ModalRoute.withName(route)),
        //Elimina la última página y redirecciona a la anterior.
        child: type == 'error'
            ? Text(errorMessageButton ??
                "Cerrar")
            : Text(successMessageButton ??
                "Aceptar"),
      );
}

// * Alertas de dos acciones (Aceptar y cancelar)
void displayDialogTwoActionsIOS(
        BuildContext context, String message, void Function() customFunction) =>
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cancel_outlined,
              color: AppTheme.dangerColor,
              size: 150.0,
            ),
            const SizedBox(height: 30),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.dangerColor,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              const _CancelAlertButton(),
              const SizedBox(width: 20),
              _ConfirmAlertButton(customFunction),
            ],
          ),
        ],
      ),
    );

void displayDialogTwoActionsAndroid(
        BuildContext context, String message, void Function() customFunction) =>
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(5)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.cancel_outlined,
              color: AppTheme.dangerColor,
              size: 150.0,
            ),
            const SizedBox(height: 30),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.dangerColor,
                fontSize: 30,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          Row(
            children: [
              const _CancelAlertButton(),
              const SizedBox(width: 15),
              _ConfirmAlertButton(customFunction),
            ],
          ),
        ],
      ),
    );

class _ConfirmAlertButton extends StatelessWidget {
  final VoidCallback customFunction;

  const _ConfirmAlertButton(this.customFunction);

  @override
  Widget build(BuildContext context) => TextButton(
        style: ButtonStyle(
          fixedSize:
              MaterialStateProperty.resolveWith((_) => const Size(120, 48)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          foregroundColor: MaterialStateColor.resolveWith((_) => Colors.white),
          backgroundColor:
              MaterialStateColor.resolveWith((_) => AppTheme.successColor),
        ),
        onPressed: () {
          customFunction();
          Navigator.pop(context);
        },
        child: const Text("Confirmar"),
      );
}

class _CancelAlertButton extends StatelessWidget {
  const _CancelAlertButton();

  @override
  Widget build(BuildContext context) => OutlinedButton(
        style: ButtonStyle(
          fixedSize:
              MaterialStateProperty.resolveWith((_) => const Size(120, 48)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          side: MaterialStateBorderSide.resolveWith(
            (_) => const BorderSide(color: AppTheme.dangerColor, width: 2),
          ),
          foregroundColor:
              MaterialStateColor.resolveWith((_) => AppTheme.dangerColor),
          backgroundColor: MaterialStateColor.resolveWith((_) => Colors.white),
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancelar"),
      );
}
