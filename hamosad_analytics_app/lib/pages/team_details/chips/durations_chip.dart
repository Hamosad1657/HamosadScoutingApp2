import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '/models/analytics.dart';
import '/models/team/stats/duration_models.dart';
import '/theme.dart';
import '/widgets/analytics.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';
import 'rates_bar.dart';

/// Takes an entire [ChipRow].
class DurationsChip extends StatelessWidget {
  const DurationsChip({super.key, required this.title, required this.durations});

  final String title;
  final ActionDurationsStat durations;

  @override
  Widget build(BuildContext context) {
    return AnalyticsChip(
      children: <Widget>[
        Expanded(flex: 1, child: dataTitleText(title)),
        const VerticalDivider(),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _durationsTitles(),
              Gap(2 * AnalyticsTheme.appSizeRatio),
              _durationsBar().padBottom(2),
            ],
          ),
        ),
      ],
    );
  }

  Widget _durationsTitles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _durationTitle('0-2', durations.zeroToTwoRate),
        Gap(16 * AnalyticsTheme.appSizeRatio),
        _durationTitle('2-5', durations.twoToFiveRate, secondaryColor: true),
        Gap(16 * AnalyticsTheme.appSizeRatio),
        _durationTitle('5+', durations.fivePlusRate),
      ],
    );
  }

  Widget _durationTitle(String duration, double rate, {bool secondaryColor = false}) {
    return Row(
      children: <Widget>[
        dataSubtitleText(duration),
        const DotDivider().padSymmetric(horizontal: 6),
        dataSubtitleText(
          rate.toPercent(),
          color: secondaryColor ? AnalyticsTheme.secondary : AnalyticsTheme.primary,
        ),
      ],
    );
  }

  Widget _durationsBar() {
    return RatesBar(
      rates: [
        durations.zeroToTwoRate,
        durations.twoToFiveRate,
        durations.fivePlusRate,
      ],
    );
  }
}
