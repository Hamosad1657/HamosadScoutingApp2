import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';

class ScoutingDialog extends StatelessWidget {
  const ScoutingDialog({
    super.key,
    required this.content,
    this.title = '',
    this.okButton = true,
    this.actions = const [],
    this.titleIcon,
    this.iconColor,
  });

  final List actions;
  final Color? iconColor;
  final bool okButton;
  final String content, title;
  final IconData? titleIcon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ScoutingTheme.background2,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (title.isNotEmpty) const Spacer(flex: 8),
          if (titleIcon != null)
            Icon(
              titleIcon!,
              size: 54 * ScoutingTheme.appSizeRatio,
              color: iconColor ?? ScoutingTheme.primary,
            ),
          if (title.isNotEmpty) ...[
            const Spacer(flex: 1),
            ScoutingText.title(title),
            const Spacer(flex: 10),
          ],
        ],
      ),
      content: ScoutingText.body(
        content,
        height: 2.35 * ScoutingTheme.appSizeRatio,
      ),
      contentPadding: EdgeInsets.fromLTRB(
        32 * ScoutingTheme.appSizeRatio,
        8 * ScoutingTheme.appSizeRatio,
        32 * ScoutingTheme.appSizeRatio,
        0,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ...actions,
        if (okButton)
          TextButton(
            child: ScoutingText.subtitle(
              'OK',
              color: ScoutingTheme.primary,
              fontWeight: FontWeight.w600,
            ).padAll(8),
            onPressed: () => Navigator.pop(context),
          ),
      ],
    );
  }
}

void showWarningSnackBar(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: <Widget>[
          Icon(
            Icons.warning_rounded,
            color: ScoutingTheme.warning,
            size: 36 * ScoutingTheme.appSizeRatio,
          ),
          ScoutingText.subtitle(title).padLeft(16),
        ],
      ),
      backgroundColor: ScoutingTheme.background2,
      duration: 2.seconds,
    ),
  );
}
