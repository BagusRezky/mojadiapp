import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/services/firebase_report_service.dart';
import 'package:quickalert/quickalert.dart';

class UpdateStatusModal {
  static void show(BuildContext context, Report report) {
    String newStatus = report.statusList.last['status'] ?? 'Belum Selesai';
    String newStatusDeskripsi = '';

    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: 'Update Status',
      widget: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            children: [
              DropdownButton<String>(
                value: newStatus,
                items: ['Belum Selesai', 'Proses', 'Selesai']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    newStatus = value!;
                  });
                },
              ),
              if (newStatus == 'Proses' || newStatus == 'Selesai')
                TextField(
                  onChanged: (value) {
                    newStatusDeskripsi = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Deskripsi Status',
                    labelStyle: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      onConfirmBtnTap: () async {
        try {
          await FirebaseReportService().updateReportStatus(
            report.id,
            newStatus,
            newStatusDeskripsi,
          );
          Navigator.pop(context); // Menutup QuickAlert dialog
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            title: 'Success',
            text: 'Status laporan berhasil diubah.',
          );
        } catch (e) {
          print('Error updating status: $e');
          Navigator.pop(context); // Menutup QuickAlert dialog
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Error',
            text: 'Gagal mengubah status laporan. Coba lagi.',
          );
        }
      },
    );
  }
}
