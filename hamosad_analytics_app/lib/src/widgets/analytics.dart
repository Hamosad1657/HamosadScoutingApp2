import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/models.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';

class AnalyticsFadeSwitcher extends StatelessWidget {
  const AnalyticsFadeSwitcher({
    Key? key,
    required this.child,
    this.duration,
  }) : super(key: key);

  final Widget child;
  final Duration? duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration ?? 250.milliseconds,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: child,
      ),
      child: child,
    );
  }
}

class AnalyticsContainer extends StatelessWidget {
  const AnalyticsContainer({
    Key? key,
    this.child,
    this.width,
    this.height,
    this.alignment,
    this.padding,
    this.border,
    this.borderRadius = 5.0,
    this.color = AnalyticsTheme.background2,
  }) : super(key: key);

  final Widget? child;
  final double? width, height;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  final double borderRadius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
      ),
      alignment: alignment,
      child: child,
    );
  }
}

class AnalyticsDataDivider extends StatelessWidget {
  const AnalyticsDataDivider({
    Key? key,
    this.flex = 1,
    this.width = 2.0,
    this.height = 45.0,
    this.color = AnalyticsTheme.background3,
  }) : super(key: key);

  final int flex;
  final double width, height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: AnalyticsContainer(
        height: height,
        width: width,
        color: AnalyticsTheme.background3,
        borderRadius: 1.0,
      ),
    );
  }
}

class AnalyticsDataChip extends StatelessWidget {
  const AnalyticsDataChip(this.data, {Key? key, required this.title})
      : super(key: key);

  final String data, title;

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 220,
      height: 70,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: AnalyticsText.dataSubtitle(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const EmptyExpanded(flex: 1),
          const AnalyticsDataDivider(),
          const EmptyExpanded(flex: 1),
          Expanded(
            flex: 30,
            child: AnalyticsText.data(data),
          ),
        ],
      ),
    );
  }
}

class AnalyticsStatChip extends StatelessWidget {
  const AnalyticsStatChip({
    Key? key,
    required this.title,
    required this.average,
    required this.min,
    required this.max,
  }) : super(key: key);

  AnalyticsStatChip.fromStat(Stat stat, {super.key, required this.title})
      : average = stat.average,
        min = stat.min,
        max = stat.max;

  final String title;
  final num average, min, max;

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 330,
      height: 70,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          Expanded(
            flex: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: AnalyticsText.dataSubtitle(
                title,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const EmptyExpanded(flex: 5),
          const AnalyticsDataDivider(),
          const EmptyExpanded(flex: 5),
          Expanded(
            flex: 40,
            child: _buildAverage(),
          ),
          const EmptyExpanded(flex: 5),
          const AnalyticsDataDivider(),
          const EmptyExpanded(flex: 5),
          Expanded(
            flex: 40,
            child: _buildMinMax(),
          ),
        ],
      ),
    );
  }

  Widget _buildAverage() => Row(
        children: [
          Expanded(
            flex: 5,
            child: AnalyticsText.dataSubtitle(
              'Avg.',
              color: AnalyticsTheme.primary,
            ),
          ),
          Expanded(
            flex: 4,
            child: AnalyticsText.data(average.toString()),
          ),
        ],
      );

  Widget _buildMinMax() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              const Expanded(
                flex: 8,
                child: Icon(
                  Icons.arrow_circle_up_rounded,
                  size: 20.0,
                  color: AnalyticsTheme.foreground1,
                ),
              ),
              const EmptyExpanded(flex: 1),
              Expanded(
                flex: 30,
                child: AnalyticsText.dataSubtitle(
                  max.toString(),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Expanded(
                flex: 8,
                child: Icon(
                  Icons.arrow_circle_down_rounded,
                  size: 20.0,
                  color: AnalyticsTheme.foreground1,
                ),
              ),
              const EmptyExpanded(flex: 1),
              Expanded(
                flex: 30,
                child: AnalyticsText.dataSubtitle(
                  min.toString(),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      );
}

class AnalyticsTwoRateChip extends StatelessWidget {
  const AnalyticsTwoRateChip({
    Key? key,
    required this.first,
    required this.second,
    this.inContainer = true,
    this.firstColor = AnalyticsTheme.primary,
    this.secondColor = AnalyticsTheme.error,
  }) : super(key: key);

  const AnalyticsTwoRateChip.pieces(
      {super.key,
      required num cones,
      required num cubes,
      this.inContainer = true})
      : first = cones,
        second = cubes,
        firstColor = AnalyticsTheme.cones,
        secondColor = AnalyticsTheme.cubes;

  final num first, second;
  final bool inContainer;
  final Color firstColor, secondColor;

  @override
  Widget build(BuildContext context) {
    return inContainer
        ? AnalyticsContainer(
            width: 220,
            height: 70,
            color: AnalyticsTheme.background1,
            child: _buildWinRate(8.0, 4.0),
          )
        : _buildWinRate(3.0, 2.5);
  }

  Widget _buildWinRate(double gap, double barHeight) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                flex: 10,
                child: AnalyticsText.data(
                  (first is int)
                      ? first.toString()
                      : first.toStringAsPrecision(3),
                  color: firstColor,
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(
                  height: 25.0,
                  child: VerticalDivider(
                    color: AnalyticsTheme.background3,
                    thickness: 2,
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: AnalyticsText.data(
                  (second is int)
                      ? second.toString()
                      : second.toStringAsPrecision(3),
                  color: secondColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: gap),
            child: (first == 0 && second == 0)
                ? Container(
                    height: barHeight,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(2.0),
                        bottomLeft: Radius.circular(2.0),
                      ),
                      color: AnalyticsTheme.background3,
                    ),
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: (first * 10).toInt(),
                        child: Container(
                          height: barHeight,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2.0),
                              bottomLeft: Radius.circular(2.0),
                            ),
                            color: firstColor,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: (second * 10).toInt(),
                        child: Container(
                          height: barHeight,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(2.0),
                              bottomRight: Radius.circular(2.0),
                            ),
                            color: secondColor,
                          ),
                        ),
                      ),
                    ],
                  ),
          )
        ],
      );
}

class AnalyticsClimbsStatChip extends StatelessWidget {
  const AnalyticsClimbsStatChip(
    this.data, {
    Key? key,
    this.dockedByOther = true,
  }) : super(key: key);

  final ClimbingStateStat data;
  final bool dockedByOther;

  Widget _buildDivider() => const Expanded(
        flex: 1,
        child: SizedBox(
          width: 15.0,
          height: 25.0,
          child: VerticalDivider(
            color: AnalyticsTheme.background3,
            thickness: 2,
          ),
        ),
      );

  Widget _buildText(String text) => Expanded(
        flex: 10,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AnalyticsText.data(
            text,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 400,
      height: 70,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          _buildText('None:\n${data.noneRate.toString()}'),
          _buildDivider(),
          _buildText('Docked:\n${data.dockedRate.toString()}'),
          if (dockedByOther) ...[
            _buildDivider(),
            _buildText('By Other:\n${data.dockedByOtherRate.toString()}'),
          ],
          _buildDivider(),
          _buildText('Engaged:\n${data.engagedRate.toString()}'),
        ],
      ),
    );
  }
}

class AnalyticsDurationsStatChip extends StatelessWidget {
  const AnalyticsDurationsStatChip(
    this.data, {
    Key? key,
    required this.title,
  }) : super(key: key);

  final ActionDurationStat data;
  final String title;

  Widget _buildDivider() => const Expanded(
        flex: 1,
        child: SizedBox(
          width: 15.0,
          height: 25.0,
          child: VerticalDivider(
            color: AnalyticsTheme.background3,
            thickness: 2,
          ),
        ),
      );

  Widget _buildText(String text) => Expanded(
        flex: 8,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: AnalyticsText.data(
            text,
          ),
        ),
      );

  Color _barColor(double t) =>
      Color.lerp(AnalyticsTheme.primary, AnalyticsTheme.primaryVariant, t)!;

  Widget _buildBars() => Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0),
        child: (data.zeroToTwoRate == 0 &&
                data.twoToFiveRate == 0 &&
                data.fivePlusRate == 0.0)
            ? Container(
                height: 3.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2.0),
                    bottomLeft: Radius.circular(2.0),
                  ),
                  color: AnalyticsTheme.background3,
                ),
              )
            : Row(
                children: [
                  Expanded(
                    flex: (data.zeroToTwoRate * 10).toInt(),
                    child: Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(2.0),
                          bottomLeft: Radius.circular(2.0),
                        ),
                        color: _barColor(0.0),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (data.twoToFiveRate * 10).toInt(),
                    child: Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                        ),
                        color: _barColor(0.5),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: (data.fivePlusRate * 10).toInt(),
                    child: Container(
                      height: 3.0,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(2.0),
                          bottomRight: Radius.circular(2.0),
                        ),
                        color: _barColor(1.0),
                      ),
                    ),
                  ),
                ],
              ),
      );

  @override
  Widget build(BuildContext context) {
    return AnalyticsContainer(
      width: 400,
      height: 70,
      color: AnalyticsTheme.background1,
      child: Row(
        children: [
          Expanded(
            flex: 12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnalyticsText.dataSubtitle(title),
            ),
          ),
          _buildDivider(),
          Column(
            children: [
              Row(
                children: [
                  _buildText(
                      '0-2:\n${data.zeroToTwoRate.toStringAsPrecision(3)}'),
                  _buildDivider(),
                  _buildText(
                      '2-5:\n${data.twoToFiveRate.toStringAsPrecision(3)}'),
                  _buildDivider(),
                  _buildText(
                      '5+:\n${data.fivePlusRate.toStringAsPrecision(3)}'),
                ],
              ),
              _buildBars(),
            ],
          ),
        ],
      ),
    );
  }
}

class AnalyticsText {
  static Text navigation(String data) {
    return Text(
      data,
      style: AnalyticsTheme.navigationTextStyle,
    );
  }

  static Widget dataTitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        style: AnalyticsTheme.dataTitleTextStyle.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
      ),
    );
  }

  static Widget dataSubtitle(
    String data, {
    Color? color,
    FontWeight? fontWeight,
    TextAlign? textAlign,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        style: AnalyticsTheme.dataSubtitleTextStyle.copyWith(
          color: color,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
      ),
    );
  }

  static Widget data(
    String data, {
    Color? color,
    TextAlign textAlign = TextAlign.center,
    double? fontSize,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        style: AnalyticsTheme.dataTextStyle.copyWith(
          color: color,
          fontSize: fontSize,
        ),
        textAlign: textAlign,
      ),
    );
  }

  static Widget logo(
    String data, {
    Color? color,
  }) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data,
        style: AnalyticsTheme.logoTextStyle.copyWith(color: color),
      ),
    );
  }
}

class AnalyticsPageTitle extends StatelessWidget {
  const AnalyticsPageTitle({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 30.0),
        SizedBox(
          width: 120.0,
          height: 30.0,
          child: Align(
            alignment: Alignment.centerRight,
            child: AnalyticsText.dataTitle(title),
          ),
        ),
        const SizedBox(
          width: 50.0,
          height: 30.0,
          child: VerticalDivider(
            color: AnalyticsTheme.foreground1,
            thickness: 1.5,
            width: 30.0,
          ),
        ),
        SizedBox(
          width: 450.0,
          height: 30.0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnalyticsText.dataSubtitle(subtitle),
          ),
        ),
      ],
    );
  }
}
