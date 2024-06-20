import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mojadiapp/helper/color_styles.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/pages/home/report/components/content_detail_report.dart';
import 'package:mojadiapp/pages/home/report/components/modal_status_update.dart';
import 'package:mojadiapp/pages/home/report/components/popup_menu.dart';
import 'package:mojadiapp/services/firebase_report_service.dart';
import 'package:quickalert/quickalert.dart'; // Import the new widget

class DetailReportScreen extends StatefulWidget {
  final Report report;

  const DetailReportScreen({super.key, required this.report});

  @override
  _DetailReportScreenState createState() => _DetailReportScreenState();
}

class _DetailReportScreenState extends State<DetailReportScreen> {
  bool showDescription = true;

  void _showStatusAlert(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Oops!',
      text: 'Status laporan sudah selesai, tidak bisa diubah lagi.',
    );
  }

  void _deleteReport(BuildContext context) async {
    await FirebaseReportService().deleteReport(widget.report.id);
    Navigator.pop(context);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Laporan berhasil dihapus.',
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
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          ReportPopupMenu(
            report: widget.report,
            onUpdateStatus: () =>
                UpdateStatusModal.show(context, widget.report),
            onDelete: () => _deleteReport(context),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<Report>(
        stream: FirebaseReportService().fetchReportStream(widget.report.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('Laporan tidak ditemukan'));
          }

          Report report = snapshot.data!;

          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.sp),
                    child: Container(
                      height: 192.h,
                      width: double.infinity,
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
                          SizedBox(
                            width: 160.w,
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today),
                                8.horizontalSpace,
                                Text(
                                  DateFormat('dd MMM y')
                                      .format(DateTime.parse(report.tanggal)),
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
                              const Icon(Icons.menu_open),
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
                          SizedBox(
                            width: 160.w,
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
                              const Icon(Icons.person),
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
                      ),
                    ],
                  ),
                  16.verticalSpace,
                  Container(
                    width: double.infinity,
                    height: 34.h,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5.sp),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showDescription = true;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: showDescription
                                    ? ColorsConstants.blue
                                    : ColorsConstants.lightBlue,
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(5.sp)),
                              ),
                              child: Center(
                                child: Text(
                                  'Deskripsi',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: showDescription
                                        ? Colors.white
                                        : const Color(0xFF898989),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showDescription = false;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: showDescription
                                    ? ColorsConstants.lightBlue
                                    : ColorsConstants.blue,
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(5.sp),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Perkembangan',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: showDescription
                                        ? const Color(0xFF898989)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.verticalSpace,
                  ReportDetailContent(
                    showDescription: showDescription,
                    report: report,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
