import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/pages/home/article/article_detail.dart';
import 'package:mojadiapp/widgets/my_button.dart';

class ArticleCardHome extends StatefulWidget {
  final Article article;

  const ArticleCardHome({super.key, required this.article});

  @override
  State<ArticleCardHome> createState() => _ArticleCardHomeState();
}

class _ArticleCardHomeState extends State<ArticleCardHome> {
  @override
  Widget build(BuildContext context) {
    String formattedDate =
        DateFormat('dd MMM yyyy').format(widget.article.timestamp.toDate());

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color.fromARGB(101, 206, 234, 255),
        borderRadius: BorderRadius.circular(11),
        border: Border.all(
          width: 1.5.sp,
          color: const Color.fromARGB(255, 144, 201, 248),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.sp),
            child: Container(
              width: double.infinity,
              height: 102.h,
              decoration: const BoxDecoration(
                color: Colors.grey,
              ),
              child: widget.article.imageUrl.isNotEmpty
                  ? Image.network(widget.article.imageUrl, fit: BoxFit.cover)
                  : const Text('No Image'),
            ),
          ),
          5.verticalSpace,
          Expanded(child: _buildArticleText(widget.article, formattedDate)),
        ],
      ),
    );
  }

  Widget _buildArticleText(Article article, String formattedDate) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          article.title,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            color: Colors.black,
          ),
        ),
        5.verticalSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            MyButton(
              text: 'Baca Selengkapnya',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailArticleScreen(article: article),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
