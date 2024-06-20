import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/services/firebase_report_service.dart';
import 'package:mojadiapp/widgets/my_button.dart';
import 'package:quickalert/quickalert.dart';

class UpdateStatusModal {
  static void show(BuildContext context, Report report) {
    String currentStatus = report.statusList.last['status'] ?? 'Belum Selesai';
    String newStatus = currentStatus;
    String newStatusDeskripsi = '';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 20,
            right: 20,
          ),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              // Determine available statuses based on current status
              List<String> availableStatuses;
              if (currentStatus == 'Belum Selesai') {
                availableStatuses = ['Belum Selesai', 'Proses', 'Selesai'];
                if (!availableStatuses.contains(newStatus)) {
                  newStatus = availableStatuses.first;
                }
              } else if (currentStatus == 'Proses') {
                availableStatuses = ['Proses', 'Selesai'];
                if (!availableStatuses.contains(newStatus)) {
                  newStatus = availableStatuses.first;
                }
              } else {
                availableStatuses = [currentStatus];
                if (!availableStatuses.contains(newStatus)) {
                  newStatus = availableStatuses.first;
                }
              }

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Perbarui Status Laporan',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  20.verticalSpace,
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Status Laporan',
                      labelStyle: GoogleFonts.roboto(
                        color: Colors.black,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                          color: Color(0xFF1564C0),
                        ),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    value: newStatus,
                    items: availableStatuses
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
                  20.verticalSpace,
                  if (newStatus == 'Proses' || newStatus == 'Selesai')
                    TextField(
                      onChanged: (value) {
                        newStatusDeskripsi = value;
                      },
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Deskripsi Status',
                        hintText: 'Masukkan deskripsi status',
                        labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFF1564C0),
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),
                  20.verticalSpace,
                  MyButton(
                    text: 'Update Laporan',
                    onPressed: () async {
                      try {
                        await FirebaseReportService().updateReportStatus(
                          report.id,
                          newStatus,
                          newStatusDeskripsi,
                        );
                        Navigator.pop(context); // Menutup modal sheet
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          title: 'Success',
                          text: 'Status laporan berhasil diubah.',
                        );
                      } catch (e) {
                        print('Error updating status: $e');
                        Navigator.pop(context); // Menutup modal sheet
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.error,
                          title: 'Error',
                          text: 'Gagal mengubah status laporan. Coba lagi.',
                        );
                      }
                    },
                  ),
                  10.verticalSpace,
                ],
              );
            },
          ),
        );
      },
    );
  }
}
