import 'package:flutter/widgets.dart';

abstract class BaseActionData {
  BaseActionData({
    this.onPressed,
    this.title,
  });

  /// Handles the [VoidCallback] whenever this action is pressed.
  final VoidCallback? onPressed;

  /// Represents appropriate [Widget] to display in title section of this action.
  final Widget? title;
}
