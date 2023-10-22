import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/models/game_report/game_report.dart';
import '/services/database.dart';
import '/theme.dart';
import '/widgets/alerts.dart';
import '/widgets/icon_button.dart';
import '/widgets/paddings.dart';
import '/widgets/text.dart';
import 'widgets/report_tab.dart';

class ReportPage extends ConsumerWidget {
  final String title;
  final List<ReportTab> tabs;

  const ReportPage({
    super.key,
    required this.title,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final report = ref.read(gameReportProvider);

    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: ScoutingTheme.background1,
          appBar: AppBar(
            toolbarHeight: 80.0 * ScoutingTheme.appSizeRatio,
            backgroundColor: ScoutingTheme.background2,
            actions: [
              _buildSendButton(context, report),
            ],
            leading: _buildCloseButton(context),
            title: ScoutingText.navigation(title, fontSize: 32.0 * ScoutingTheme.appSizeRatio),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              indicatorWeight: 2.5 * ScoutingTheme.appSizeRatio,
              indicatorColor: ScoutingTheme.primary,
              labelPadding: EdgeInsets.symmetric(horizontal: 24.0 * ScoutingTheme.appSizeRatio),
              labelColor: ScoutingTheme.foreground1,
              unselectedLabelColor: ScoutingTheme.foreground2,
              labelStyle: ScoutingTheme.navigationStyle.copyWith(fontSize: 16.0),
              tabs: [
                for (final tab in tabs)
                  Tab(
                    text: tab.title,
                    height: 52.0 * ScoutingTheme.appSizeRatio,
                  ),
              ],
            ),
          ),
          body: TabBarView(
            children: tabs,
          ).padSymmetric(vertical: 16.0),
        ),
      ),
    );
  }

  Widget _buildSendButton(BuildContext context, GameReport report) {
    return ScoutingIconButton(
      icon: Icons.send_rounded,
      color: ScoutingTheme.blueAlliance,
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              String? content;

              if (report.match.data.isNullOrEmpty || report.teamNumber.data.isNullOrEmpty) {
                content = 'Please fill the match and team number.';
              } else if (report.summary.defenseFocus.data == null) {
                content = 'Please fill the defense focus.';
              }

              if (content == null) {
                return _buildSendReportDialog(context, report);
              } else {
                return ScoutingDialog(
                  content: content,
                  title: 'Incomplete report',
                  iconColor: ScoutingTheme.warning,
                  titleIcon: Icons.warning_rounded,
                );
              }
            });
      },
    );
  }

  Widget _buildSendReportDialog(BuildContext context, report) {
    return ScoutingDialog(
      content:
          'Sending the report will upload it to the database and bring you back to the home screen.',
      title: 'Send Report?',
      titleIcon: Icons.send_rounded,
      iconColor: ScoutingTheme.blueAlliance,
      okButton: false,
      actions: [
        padAll(
          8.0,
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: ScoutingText.body('Cancel', color: ScoutingTheme.primary).padAll(4.0),
          ),
        ),
        padAll(
          8.0,
          TextButton(
            onPressed: () => _sendReport(context, report),
            child: ScoutingText.body(
              'Send',
              color: ScoutingTheme.blueAlliance,
              fontWeight: FontWeight.bold,
            ).padAll(4.0),
          ),
        ),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return ScoutingIconButton(
      icon: Icons.close_rounded,
      iconSize: 26.0,
      color: ScoutingTheme.foreground2,
      onPressed: () async {
        showDialog(context: context, builder: _buildCloseReportDialog);
      },
    );
  }

  Widget _buildCloseReportDialog(BuildContext context) {
    return ScoutingDialog(
      content: 'Closing the report will delete all of the information entered.',
      title: 'Warning!',
      titleIcon: Icons.dangerous_rounded,
      iconColor: ScoutingTheme.error,
      okButton: false,
      actions: [
        padAll(
          8.0,
          TextButton(
            onPressed: () {
              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );
            },
            child: ScoutingText.body(
              'Delete',
              color: ScoutingTheme.error,
              fontWeight: FontWeight.bold,
            ).padAll(4.0),
          ),
        ),
        padAll(
          8.0,
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: ScoutingText.body('Cancel', color: ScoutingTheme.primary).padAll(4.0),
          ),
        ),
      ],
    );
  }

  void _sendReport(BuildContext context, GameReport report) async {
    Navigator.popUntil(context, (route) => route.isFirst);

    try {
      ScoutingDatabase.sendReport(report.data).then(
        (_) {
          report.clear();
          Phoenix.rebirth(context);
        },
      );
    } catch (e) {
      showWarningSnackBar(context, 'Failed to send report.');
    }
  }
}
