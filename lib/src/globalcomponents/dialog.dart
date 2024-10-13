import 'package:flutter/material.dart';

showAlertDialog(
    {required BuildContext context,
    required String title,
    required Widget content,
    required List<Widget> actions}) async {
  return await showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: true,
      builder: (context) {
        return AlertDialog(
            title: Text(title), content: content, actions: actions);
      });
}
