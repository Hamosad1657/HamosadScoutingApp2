import 'package:flutter/material.dart';

import '/theme.dart';
import '/widgets/data/analytics_chip.dart';
import '/widgets/text.dart';

class TeamInfoChip extends StatelessWidget {
  const TeamInfoChip(this.info, {super.key, required this.icon});

  final String info;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: AnalyticsChip(
        label: dataTitleText(
          info,
          textAlign: TextAlign.left,
        ),
        avatar: Icon(
          icon,
          size: 35.0 * AnalyticsTheme.appSizeRatio,
          color: AnalyticsTheme.primaryVariant,
        ),
      ),
    );
  }
}
