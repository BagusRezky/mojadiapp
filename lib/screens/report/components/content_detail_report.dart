// lib/screens/detail_report/components/report_detail_content.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mojadiapp/models/report_model.dart';

class ReportDetailContent extends StatelessWidget {
  final bool showDescription;
  final Report report;

  const ReportDetailContent({
    super.key,
    required this.showDescription,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    return showDescription
        ? Text(
            report.deskripsi,
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w400,
              fontSize: 14.sp,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status:',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
              for (var status in report.statusList)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status: ${status['status']}',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                      if (status['deskripsi']!.isNotEmpty)
                        Text(
                          'Deskripsi Status: ${status['deskripsi']}',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                          ),
                        ),
                      // Tampilkan timestamp pada tiap status
                      Text(
                        'Waktu: ${status['timestamp'].toDate().toString()}',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
  }
}
