import 'package:flutter/material.dart';

displayToast(String message, BuildContext context) {
  var toast = SnackBar(content: Text(message),);

  ScaffoldMessenger.of(context).showSnackBar(toast);
}