import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '/models/report/report_model.dart';
import '/theme.dart';
import '/widgets/paddings.dart';
import '/widgets/scaffold.dart';
import 'charts/analytics_chart.dart';
import 'charts/chart_with_selection.dart';
import 'charts/charts.dart';
import 'teams/selected_teams_chips.dart';
import 'teams/teams_select.dart';

class ComparePage extends StatelessWidget {
  const ComparePage({super.key, this.selectedTeams});

  final List<String>? selectedTeams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AnalyticsAppBar(title: 'Compare Teams'),
      drawer: const AnalyticsDrawer(),
      body: padSymmetric(
        horizontal: 12,
        vertical: 12,
        Column(
          children: <Widget>[
            _teamsSelect(context),
            Gap(10 * AnalyticsTheme.appSizeRatio),
            if (selectedTeams != null) _selectedTeamsChips(context).padBottom(12),
            const Divider(),
            Gap(8 * AnalyticsTheme.appSizeRatio),
            Expanded(
              child: _charts({
                '1577': [
                  const Report(15),
                  const Report(10),
                  const Report(12),
                  const Report(17),
                  const Report(12),
                  const Report(14),
                  const Report(18),
                ],
                '1657': [
                  const Report(4),
                  const Report(3),
                  const Report(6),
                ],
                '1690': [
                  const Report(16),
                  const Report(21),
                  const Report(13),
                  const Report(15),
                ],
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _teamsSelect(BuildContext context) {
    return TeamsSelect(
      teams: TeamInfo.teams,
      selectedTeams: selectedTeams,
      onSelectionChange: (teams) {
        if (selectedTeams == null || !listEquals(selectedTeams!, teams)) {
          context.go(_newPageUri(teams).toString());
        }
      },
    );
  }

  Widget _selectedTeamsChips(BuildContext context) {
    return SelectedTeamsChips(
      selectedTeams: selectedTeams!,
      onSelectionChange: (teams) {
        context.go(_newPageUri(teams).toString());
      },
    );
  }

  Widget _charts(TeamsWithReports teamsWithReports) {
    return ListView.builder(
      itemCount: Charts.length,
      itemBuilder: (context, index) => padBottom(
        16,
        ChartWithSelection(
          initialChartIndex: index,
          selectedTeams: selectedTeams ?? [],
          teamsWithReports: teamsWithReports,
        ),
      ),
    );
  }

  Uri _newPageUri(List<String> teams) {
    return Uri(
      path: '/compare',
      queryParameters: {
        if (teams.isNotEmpty) 'teams': teams.join(','),
      },
    );
  }
}
