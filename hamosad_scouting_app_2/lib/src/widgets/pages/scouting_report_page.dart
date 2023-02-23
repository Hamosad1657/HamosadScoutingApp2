import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/constants.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:hamosad_scouting_app_2/src/widgets.dart';

class ScoutingReportPage extends StatelessWidget {
  final String title;
  final List<ScoutingReportTab> tabs;
  final double size;

  const ScoutingReportPage({
    Key? key,
    required this.title,
    required this.tabs,
    this.size = 1.0,
  }) : super(key: key);

  void _onCloseButtonPressed(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => ScoutingAlertDialog(
        content:
            'Closing the report will delete all of the information entered.',
        title: 'Warning!',
        titleIcon: Icons.dangerous_rounded,
        iconColor: ScoutingTheme.error,
        okButton: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ScoutingText.text(
                  'Delete',
                  color: ScoutingTheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ScoutingText.text(
                  'Cancel',
                  color: ScoutingTheme.primary,
                ),
              ),
            ),
          ),
        ],
        size: size,
      ),
    );
  }

  void _onSendButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => ScoutingAlertDialog(
        content:
            'Sending the report will upload it to the database and bring you back to the home screen.',
        title: 'Send Report?',
        titleIcon: Icons.send_rounded,
        iconColor: ScoutingTheme.blueAlliance,
        okButton: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ScoutingText.text(
                  'Cancel',
                  color: ScoutingTheme.primary,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () async {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );

                final reportData = reportDataProvider(context);
                await ScoutingDatabase.sendReport(
                  reportData.data,
                  reportType: reportData.reportType.data,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ScoutingText.text(
                  'Send',
                  color: ScoutingTheme.blueAlliance,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: ScoutingTheme.background1,
          appBar: AppBar(
            toolbarHeight: 80.0 * size,
            backgroundColor: ScoutingTheme.background2,
            actions: [
              ScoutingIconButton(
                icon: Icons.send_rounded,
                color: ScoutingTheme.blueAlliance,
                onPressed: () => _onSendButtonPressed(context),
              ),
            ],
            leading: ScoutingIconButton(
              icon: Icons.close_rounded,
              iconSize: 26.0,
              color: ScoutingTheme.foreground2,
              onPressed: () => _onCloseButtonPressed(context),
            ),
            title: ScoutingText.navigation(title, fontSize: 32.0 * size),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              indicatorWeight: 2.5 * size,
              indicatorColor: ScoutingTheme.primary,
              labelPadding: EdgeInsets.symmetric(horizontal: 24.0 * size),
              labelColor: ScoutingTheme.foreground1,
              unselectedLabelColor: ScoutingTheme.foreground2,
              labelStyle:
                  ScoutingTheme.navigationStyle.copyWith(fontSize: 16.0),
              tabs: [
                for (final tab in tabs)
                  Tab(
                    text: tab.title,
                    height: 52.0 * size,
                  ),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0 * size),
            child: TabBarView(
              children: tabs,
            ),
          ),
        ),
      ),
    );
  }
}
