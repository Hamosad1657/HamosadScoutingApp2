import 'package:flutter/material.dart';

import '/theme.dart';

Widget navigationText(dynamic data, {TextAlign textAlign = TextAlign.center}) => FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data.toString(),
        style: AnalyticsTheme.navigationStyle,
        textAlign: textAlign,
      ),
    );

Widget navigationTitleText(dynamic data, {TextAlign textAlign = TextAlign.center}) => FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data.toString(),
        style: AnalyticsTheme.navigationTitleStyle,
        textAlign: textAlign,
      ),
    );

Widget dataTitleText(dynamic data, {TextAlign textAlign = TextAlign.center}) => FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data.toString(),
        style: AnalyticsTheme.dataTitleStyle,
        textAlign: textAlign,
      ),
    );

Widget dataSubtitleText(dynamic data, {TextAlign textAlign = TextAlign.center}) => FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data.toString(),
        style: AnalyticsTheme.dataSubtitleStyle,
        textAlign: textAlign,
      ),
    );

Widget dataBodyText(dynamic data, {TextAlign textAlign = TextAlign.center}) => FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data.toString(),
        style: AnalyticsTheme.dataBodyStyle,
        textAlign: textAlign,
      ),
    );

Widget logoText(dynamic data) => FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        data.toString(),
        style: AnalyticsTheme.logoTextStyle,
      ),
    );
