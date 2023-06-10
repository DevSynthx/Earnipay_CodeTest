import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef BaseDialogBuilder<T> = T Function(BuildContext context);

abstract class BaseDialog<A extends Widget, I extends Widget>
    extends StatelessWidget {
  const BaseDialog({super.key});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return buildMaterialWidget(context);
    } else {
      final platform = Theme.of(context).platform;

      switch (platform) {
        case TargetPlatform.fuchsia:
        case TargetPlatform.linux:
        case TargetPlatform.windows:
        case TargetPlatform.android:
          return buildMaterialWidget(context);
        case TargetPlatform.macOS:
        case TargetPlatform.iOS:
          return buildCupertinoWidget(context);
        default:
          throw UnsupportedError("Platform is not supported by this plugin.");
      }
    }
  }

  A buildMaterialWidget(BuildContext context);

  I buildCupertinoWidget(BuildContext context);
}
