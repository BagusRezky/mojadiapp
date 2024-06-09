import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/screens/artikel/detail_article.dart';
import 'package:mojadiapp/services/firebase_article_service.dart';

class ListArticleScreen extends StatefulWidget {
  const ListArticleScreen({super.key});

  @override
  State<ListArticleScreen> createState() => _ListArticleScreenState();
}

class _ListArticleScreenState extends State<ListArticleScreen> {
  late Future<List<Article>> _articlesFuture;

  @override
  void initState() {
    super.initState();
    _articlesFuture = FirebaseArticleService().fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Semua Artikel',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            height: 36.sp,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onSelected: (String result) {
              switch (result) {
                case 'Add Artikel':
                  Navigator.pushNamed(context, '/article/create');
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Add Artikel',
                child: Text('Tambah Artikel'),
              ),
            ],
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder<List<Article>>(
        future: _articlesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Tidak ada laporan'));
          }

          List<Article> articles = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
              Article article = articles[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailArticleScreen(article: article),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
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
                      Expanded(child: textArticle(article)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.sp),
                        child: Container(
                          width: 125.w,
                          height: 80.h,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                          ),
                          child: article.imageUrl.isNotEmpty
                              ? Image.network(article.imageUrl,
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

  Widget textArticle(Article article) {
    String formattedDate =
        DateFormat('dd MMM yyyy').format(article.timestamp.toDate());

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
                'team dev',
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
