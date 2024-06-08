import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/screens/report/detail_report.dart';
import 'package:mojadiapp/services/firebase_report_service.dart';
import 'package:mojadiapp/widgets/my_report_item.dart';

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
            height: 1.5,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Report>>(
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
                  String formattedDate = DateFormat('MMM dd')
                      .format(DateTime.parse(report.tanggal));
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ReportItem(
                      imageUrl: report.imageUrl,
                      title: report.judul,
                      date: formattedDate,
                      lokasi: report.lokasi,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailReportScreen(report: report),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
