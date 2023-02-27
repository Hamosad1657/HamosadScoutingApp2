import 'dart:math' as math;

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamosad_analytics_app/src/constants.dart';
import 'package:hamosad_analytics_app/src/database.dart';
import 'package:hamosad_analytics_app/src/pages.dart';
import 'package:hamosad_analytics_app/src/widgets.dart';
import 'package:sidebarx/sidebarx.dart';

class AnalyticsApp extends ConsumerWidget {
  AnalyticsApp({super.key});

  final SidebarXController _sidebarController =
      SidebarXController(selectedIndex: 0, extended: true);

  static double size = 1.0;

  Future<void> initializeDatabase(WidgetRef ref) async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await ref.read(analyticsDatabaseProvider).updateFromFirestore();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    size = math.min(
      screenSize.width / 1400.0,
      screenSize.height / 750.0,
    );

    return FutureBuilder(
        future: initializeDatabase(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: AnalyticsTheme.background1,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(
                color: AnalyticsTheme.primary,
              ),
            );
          }
          return Portal(
            child: MaterialApp(
              title: 'Scouting Analytics',
              themeMode: ThemeMode.dark,
              home: Scaffold(
                backgroundColor: AnalyticsTheme.background1,
                body: Row(
                  children: [
                    Sidebar(
                      _sidebarController,
                      items: const [
                        SidebarXItem(
                          icon: Icons.people_outline_rounded,
                          label: 'Team Details',
                        ),
                        SidebarXItem(
                          icon: Icons.groups_outlined,
                          label: 'Teams',
                        ),
                        // SidebarXItem(
                        //   icon: Icons.assignment_outlined,
                        //   label: 'Report Details',
                        // ),
                        SidebarXItem(
                          icon: Icons.assessment_outlined,
                          label: 'Alliances',
                        ),
                      ],
                    ),
                    Expanded(
                      child: AnalyticsAppBody(
                        sidebarController: _sidebarController,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class AnalyticsAppBody extends StatefulWidget {
  const AnalyticsAppBody({
    super.key,
    required this.sidebarController,
  });

  final SidebarXController sidebarController;

  @override
  State<AnalyticsAppBody> createState() => _AnalyticsAppBodyState();
}

class _AnalyticsAppBodyState extends State<AnalyticsAppBody> {
  final List<Widget> _pages = [
    const TeamDetailsPage(),
    const TeamsPage(),
    // const ReportDetailsPage(),
    const AlliancesPage()
  ];
  @override
  void initState() {
    super.initState();
    widget.sidebarController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return AnalyticsFadeSwitcher(
      child: Container(
        key: ValueKey<int>(widget.sidebarController.selectedIndex),
        child: _pages[widget.sidebarController.selectedIndex],
      ),
    );
  }
}

// TODO: Remove at production.
T debug<T>(T object) {
  debugPrint(object.toString());
  return object;
}
