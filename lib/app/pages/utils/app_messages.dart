import 'package:flutter/material.dart';
import 'package:poc_login/app/core/app_constants.dart';

mixin AppMessages {
  void showMessageError(BuildContext context, String msg) {
    _showMessage(context, msg, Colors.red);
  }

  void showMessageInfo(BuildContext context, String msg) {
    _showMessage(context, msg, Colors.black12);
  }

  void _showMessage(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            msg,
            style: const TextStyle(color: AppColors.black),
          ),
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          backgroundColor: color,
        ),
      );
  }
}
