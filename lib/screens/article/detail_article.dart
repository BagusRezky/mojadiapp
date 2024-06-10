import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/screens/article/components/popup_menu.dart';
import 'package:mojadiapp/services/firebase_article_service.dart';
import 'package:quickalert/quickalert.dart';

class DetailArticleScreen extends StatelessWidget {
  final Article article;

  const DetailArticleScreen({super.key, required this.article});

  void _deleteArticle(BuildContext context) async {
    await FirebaseArticleService().deleteArticle(article.id);
    Navigator.pop(context);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Success',
      text: 'Artikel berhasil dihapus',
    );
  }

  // formated timestamp dd MMMM yyyy
  String _formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return DateFormat('dd MMMM yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Artikel',
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            height: 36.sp,
          ),
        ),
        actions: [
          ArticlePopupMenu(
            article: article,
            onDelete: () => _deleteArticle(context),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
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
                  child: article.imageUrl.isNotEmpty
                      ? Image.network(article.imageUrl, fit: BoxFit.cover)
                      : const Text('No Image'),
                ),
              ),
              10.verticalSpace,
              Text(
                article.title,
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
                        width: 160.w,
                        child: Row(
                          children: [
                            const Icon(Icons.person_search),
                            8.horizontalSpace,
                            Text(
                              article.userEmail,
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
                          const Icon(Icons.calendar_today),
                          8.horizontalSpace,
                          Text(
                            _formatTimestamp(article.timestamp),
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
              Text(
                article.description,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
