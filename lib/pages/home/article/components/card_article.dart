import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/pages/home/article/article_detail.dart';

class ArticleCard extends StatelessWidget {
  final Article article;

  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd MMM yyyy').format(article.timestamp.toDate());

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailArticleScreen(article: article),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        width: double.infinity,
        height: 105.h,
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
            Expanded(child: _buildArticleText(article, formattedDate)),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.sp),
              child: Container(
                width: 125.w,
                height: 80.h,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                ),
                child: article.imageUrl.isNotEmpty
                    ? Image.network(article.imageUrl, fit: BoxFit.cover)
                    : const Text('No Image'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildArticleText(Article article, String formattedDate) {
    return Container(
      margin: EdgeInsets.only(right: 15.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title,
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
                article.userEmail,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  color: const Color.fromARGB(155, 0, 0, 0),
                ),
              ),
              Text(
                formattedDate,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  color: const Color.fromARGB(155, 0, 0, 0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
