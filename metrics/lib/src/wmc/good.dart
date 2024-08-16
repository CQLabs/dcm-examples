// ignore: prefer-match-file-name
abstract class Report {
  void generate();
}

class PDFReport extends Report {
  @override
  // ignore: no-empty-block
  void generate() {
    // simple report logic
  }
}

class ExcelReport extends Report {
  @override
  // ignore: no-empty-block
  void generate() {}
}

class ReportSender {
  const ReportSender();

  void sendByEmail(Report report) {
    print('Sending report by email $report');
  }
}

class ReportLogger {
  const ReportLogger();

  void log(Report report) {
    print('Logging report $report');
  }
}

class ReportArchiver {
  const ReportArchiver();

  void archive(Report report) {
    print('Archiving report $report');
  }
}

// This class has a lower WMC by delegating responsibilities to other classes.
class ReportGenerator {
  ReportGenerator();

  final ReportSender _reportSender = ReportSender();
  final ReportLogger _reportLogger = ReportLogger();
  final ReportArchiver _reportArchiver = ReportArchiver();

  void generateAndSendReport(Report report) {
    report.generate();
    _reportLogger.log(report);
    _reportSender.sendByEmail(report);
    _reportArchiver.archive(report);
  }
}
