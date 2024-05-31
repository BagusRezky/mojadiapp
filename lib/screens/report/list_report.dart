import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/screens/report/detail_report.dart';
import 'package:mojadiapp/services/firebase_report_service.dart';

class ListReportScreen extends StatefulWidget {
  const ListReportScreen({super.key});

  @override
  State<ListReportScreen> createState() => _ListReportScreenState();
}

class _ListReportScreenState extends State<ListReportScreen> {
  late Future<List<Report>> _reportsFuture;

  @override
  void initState() {
    super.initState();
    _reportsFuture = FirebaseReportService().fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Semua Laporan',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            height: 36.sp,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Report>>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada laporan'));
          }

          List<Report> reports = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            itemCount: reports.length,
            itemBuilder: (BuildContext context, int index) {
              Report report = reports[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailReportScreen(report: report),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                  width: 369.w,
                  height: 115.h,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(101, 206, 234, 255),
                    borderRadius: BorderRadius.circular(11),
                    border: Border.all(
                      width: 1.5.sp,
                      color: const Color.fromARGB(255, 144, 201, 248),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: textReport(report)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.sp),
                        child: Container(
                          width: 125.w,
                          height: 85.h,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: report.imageUrl.isNotEmpty
                              ? Image.network(report.imageUrl,
                                  fit: BoxFit.cover)
                              : const Text('No Image'),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget textReport(Report report) {
    String formattedDate =
        DateFormat('dd MMMM yyyy').format(DateTime.parse(report.tanggal));

    return Container(
      margin: EdgeInsets.only(right: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            report.judul,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: Colors.black,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                report.lokasi,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  color: Color.fromARGB(155, 0, 0, 0),
                ),
              ),
              Text(
                formattedDate,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  color: Color.fromARGB(155, 0, 0, 0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
