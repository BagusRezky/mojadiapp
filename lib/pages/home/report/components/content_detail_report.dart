import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mojadiapp/helper/color_styles.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:intl/intl.dart';

class ReportDetailContent extends StatelessWidget {
  final bool showDescription;
  final Report report;

  const ReportDetailContent({
    super.key,
    required this.showDescription,
    required this.report,
  });

  String formatDate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('HH:mm, dd MMMM yyyy');
    return formatter.format(dateTime);
  }

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
              for (var status in report.statusList)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 1.w,
                            height: 22.h,
                            color: Colors.grey,
                          ),
                          Container(
                            width: 8.w,
                            height: 8.h,
                            decoration: const BoxDecoration(
                              color: ColorsConstants.blue,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Container(
                            width: 1.w,
                            height: 40.h,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              formatDate(status['timestamp'].toDate()),
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 10.sp,
                              ),
                            ),
                            4.verticalSpace,
                            Text(
                              '${status['status']}',
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            Divider(
                              color: Colors.blue[400],
                              height: 20,
                              thickness: 0.8,
                              indent: 0,
                              endIndent: 0,
                            ),
                            if (status['deskripsi']!.isNotEmpty)
                              Text(
                                '${status['deskripsi']}',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
  }
}
