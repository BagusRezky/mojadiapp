import 'package:flutter/material.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/pages/home/report/report_edit.dart';
import 'package:quickalert/quickalert.dart';

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
    if (report.statusList.last['status'] == 'Selesai') {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops!',
        text: 'Status laporan sudah selesai, tidak bisa diubah lagi.',
      );
    } else {
      onUpdateStatus();
    }
  }

  void _deleteReport(BuildContext context) async {
    onDelete();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: const Icon(Icons.more_vert, color: Colors.black),
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
