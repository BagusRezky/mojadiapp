import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mojadiapp/models/report_model.dart';
// import 'package:mojadiapp/screens/edit_report_screen.dart';
import 'package:mojadiapp/services/firebase_report_service.dart';
import 'package:mojadiapp/widgets/my_button.dart';

class DetailReportScreen extends StatelessWidget {
  final Report report;

  DetailReportScreen({required this.report});

  void _showUpdateStatusModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        String newStatus = report.status;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Update Status',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
              ),
              16.verticalSpace,
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return DropdownButton<String>(
                    value: newStatus,
                    items: ['pending', 'selesai']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        newStatus = value!;
                      });
                    },
                  );
                },
              ),
              16.verticalSpace,
              MyButton(
                text: 'Update',
                onPressed: () async {
                  await FirebaseReportService().updateReportStatus(
                    report.id,
                    newStatus,
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Status updated to $newStatus')),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _deleteReport(BuildContext context) async {
    await FirebaseReportService().deleteReport(report.id);
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Report deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Laporan',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            height: 36.sp,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.sp),
                child: Container(
                  height: 192.h,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  child: report.imageUrl.isNotEmpty
                      ? Image.network(report.imageUrl, fit: BoxFit.cover)
                      : const Text('No Image'),
                ),
              ),
              10.verticalSpace,
              Text(
                report.judul,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                ),
              ),
              10.verticalSpace,
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // lokasi
                      SizedBox(
                        width: 130.w,
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today),
                            8.horizontalSpace,
                            Text(
                              report.tanggal,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 35.horizontalSpace,
                      // category
                      Row(
                        children: [
                          const Icon(Icons.category),
                          8.horizontalSpace,
                          Text(
                            report.kategori,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // lokasi
                      SizedBox(
                        width: 130.w,
                        child: Row(
                          children: [
                            const Icon(Icons.location_on),
                            8.horizontalSpace,
                            Text(
                              report.lokasi,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.people),
                          8.horizontalSpace,
                          Text(
                            report.userEmail,
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ],

                    // lokasi
                  ),
                ],
              ),
              16.verticalSpace,
              Text(
                report.deskripsi,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              16.verticalSpace,
              Text(
                'Status: ${report.status}',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
              16.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MyButton(
                    text: 'Update',
                    onPressed: () => _showUpdateStatusModal(context),
                  ),
                  8.horizontalSpace,
                  MyButton(
                    text: 'Edit',
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         EditReportScreen(report: report),
                      //   ),
                      // );
                    },
                  ),
                  8.horizontalSpace,
                  MyButton(
                    text: 'Delete',
                    onPressed: () => _deleteReport(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
