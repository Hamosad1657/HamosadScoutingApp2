import 'package:flutter/material.dart';
import 'package:hamosad_scouting_app_2/src/models.dart';
import 'package:hamosad_scouting_app_2/src/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReportDataProvider {
  final Cubit<String> scouter = Cubit('');
  final Cubit<String> scouterTeamNumber = Cubit('');
  final Cubit<String?> teamNumber = Cubit(null);
  final Cubit<String?> match = Cubit(null);
  final Cubit<ReportType> reportType = Cubit(ReportType.game);

  final GameReport gameReport = GameReport();
  final PitReport pitReport = PitReport();

  Json get data {
    final reportData =
        reportType.data == ReportType.game ? gameReport.data : pitReport.data;
    return {
      'info': {
        'scouter': scouter.data,
        'scouterTeamNumber': scouterTeamNumber.data,
        'teamNumber': teamNumber.data,
        'time': DateFormat('dd/MM HH:mm:ss').format(DateTime.now()),
        if (reportType.data == ReportType.game) 'match': match.data,
      },
      ...reportData,
    };
  }
}

class GameReport {
  final GameReportAuto auto = GameReportAuto();
  final GameReportTeleop teleop = GameReportTeleop();
  final GameReportEndgame endgame = GameReportEndgame();
  final GameReportSummary summary = GameReportSummary();

  Json get data {
    return {
      'auto': auto.data,
      'teleop': teleop.data,
      'endgame': teleop.data,
      'summary': summary.data,
    };
  }
}

class GameReportAuto {
  Cubit<StartPosition?> startPosition = Cubit(null);
  Cubit<bool> leftCommunity = Cubit(false);
  Cubit<Pickups> pickups = Cubit(Pickups());
  Cubit<Dropoffs> dropoffs = Cubit(Dropoffs());
  Cubit<int> chargeStationPasses = Cubit(0);
  Cubit<AutoClimb> climb = Cubit(AutoClimb());
  Cubit<String> notes = Cubit('');

  Json get data {
    return {
      'startPosition': startPosition.data.toString(),
      'leftCommunity': leftCommunity.data,
      'pickups': pickups.data.toJson(),
      'dropoffs': dropoffs.data.toJson(),
      'chargeStationPasses': chargeStationPasses.data,
      'climb': climb.data.toJson(),
      'notes': notes.data,
    };
  }
}

class GameReportTeleop {
  Cubit<Pickups> pickups = Cubit(Pickups());
  Cubit<Dropoffs> dropoffs = Cubit(Dropoffs());
  Cubit<int> chargeStationPasses = Cubit(0);
  Cubit<String> notes = Cubit('');

  Json get data {
    return {
      'pickups': pickups.data.toJson(),
      'dropoffs': dropoffs.data.toJson(),
      'chargeStationPasses': chargeStationPasses.data,
      'notes': notes.data,
    };
  }
}

class GameReportEndgame {
  Cubit<Pickups> pickups = Cubit(Pickups());
  Cubit<Dropoffs> dropoffs = Cubit(Dropoffs());
  Cubit<int> chargeStationPasses = Cubit(0);
  Cubit<EndgameClimb> climb = Cubit(EndgameClimb());
  Cubit<String> notes = Cubit('');

  Json get data {
    return {
      'pickups': pickups.data.toJson(),
      'dropoffs': dropoffs.data.toJson(),
      'chargeStationPasses': chargeStationPasses.data,
      'climb': climb.data.toJson(),
      'notes': notes.data,
    };
  }
}

class GameReportSummary {
  Cubit<bool> won = Cubit(false);
  Cubit<DefenceFocus?> defenceFocus = Cubit(null);
  Cubit<String> fouls = Cubit('');
  Cubit<String> notes = Cubit('');

  Json get data {
    return {
      'won': won.data,
      'defenceRobotIndex': defenceFocus.data.toString(),
      'fouls': fouls.data,
      'notes': notes.data,
    };
  }
}

class PitReport {
  final Cubit<String> notes = Cubit('');

  Json get data {
    return {
      'notes': notes.data,
    };
  }
}

ReportDataProvider reportDataProvider(BuildContext context) =>
    Provider.of<ReportDataProvider>(context, listen: false);
