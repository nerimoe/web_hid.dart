class HidReport {
  final int reportId;
  final List<int> data;
  HidReport(this.reportId, this.data);
}

typedef ReportListener = dynamic Function(HidReport report);
