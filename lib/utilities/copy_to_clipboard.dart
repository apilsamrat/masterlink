import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterlink/src/globalcomponents/toaster.dart';

Future<void> copyToClipBoard(
    {required data, required BuildContext context}) async {
  if (data != null) {
    await Clipboard.setData(ClipboardData(text: data));
    if (context.mounted) {
      AwesomeToaster.showToast(
          context: context, msg: "URL Copied to Clipboard");
    }
  } else {
    AwesomeToaster.showToast(
        context: context, msg: "Please short an URL first.");
  }
}
