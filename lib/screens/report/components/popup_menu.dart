// lib/widgets/report_popup_menu.dart

import 'package:flutter/material.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/screens/report/edit_report.dart';

class ReportPopupMenu extends StatelessWidget {
  final Report report;
  final Function onUpdateStatus;
  final Function onDelete;

  const ReportPopupMenu({
    super.key,
    required this.report,
    required this.onUpdateStatus,
    required this.onDelete,
  });

  void _showUpdateStatusAlert(BuildContext context) {
    onUpdateStatus();
  }

  void _deleteReport(BuildContext context) async {
    onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String result) {
        switch (result) {
          case 'Update Status':
            _showUpdateStatusAlert(context);
            break;
          case 'Edit Laporan':
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditReportScreen(report: report),
              ),
            );
            break;
          case 'Delete Laporan':
            _deleteReport(context);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Update Status',
          child: Text('Update Status'),
        ),
        const PopupMenuItem<String>(
          value: 'Edit Laporan',
          child: Text('Edit Laporan'),
        ),
        const PopupMenuItem<String>(
          value: 'Delete Laporan',
          child: Text('Delete Laporan'),
        ),
      ],
    );
  }
}
