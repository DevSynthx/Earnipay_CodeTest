import 'package:flutter/material.dart';
import 'package:unsplash/presentation/util/components/alert_dialog/src/basic_dialog_action.dart';
import 'package:unsplash/presentation/util/components/alert_dialog/src/basic_dialog_alert.dart';
import 'package:unsplash/presentation/util/components/alert_dialog/src/platform_dialog.dart';
import 'package:unsplash/presentation/util/helper/navigator.dart';

class ScreenAlertView {
  static showErrorDialog(
      {required BuildContext context, String errorText = ""}) {
    showPlatformDialog(
        context: context,
        builder: (_) => BasicDialogAlert(
              title: Text("Error",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      )),
              content: Text(errorText,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      )),
              actions: <Widget>[
                BasicDialogAction(
                  title: const Text("OK"),
                  onPressed: () {
                    Navigator.pop(navigator.key.currentContext!);
                  },
                ),
              ],
            ));
  }
}
