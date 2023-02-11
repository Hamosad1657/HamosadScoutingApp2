import 'package:flutter/material.dart';
import 'package:hamosad_analytics_app/components.dart';
import 'package:hamosad_analytics_app/models.dart';

class ReportDetailsPage extends StatefulWidget {
  const ReportDetailsPage({super.key, this.initReport});

  final Report? initReport;

  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  TextEditingController reportSelectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Report? selectedReport = widget.initReport;
    if (selectedReport != null) {
      reportSelectionController.text =
          '${selectedReport.info.teamNumber} - ${selectedReport.info.match} - ${selectedReport.info.scouter}';
    }

    return AppPage(
      appBar: AppBar(
        title: const Text('Report Details'),
        actions: const [AppbarBackButton()],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 20,
          right: 20,
        ),
        child: Column(
          children: [
            ReportSearchBox(
              reports: const [],
              onChange: (Report newTeam) {
                selectedReport = newTeam;
              },
              inputController: reportSelectionController,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
