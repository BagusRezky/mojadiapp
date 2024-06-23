import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/pages/home/article/components/card_article.dart';
import 'package:mojadiapp/services/firebase_article_service.dart';

class ListArticleScreen extends StatefulWidget {
  const ListArticleScreen({super.key});

  @override
  State<ListArticleScreen> createState() => _ListArticleScreenState();
}

class _ListArticleScreenState extends State<ListArticleScreen> {
  late Future<List<Article>> _articlesFuture;
  String? _searchQuery;

  @override
  void initState() {
    super.initState();
    _articlesFuture = FirebaseArticleService().fetchArticles();
  }

  void _updateArticles() {
    setState(() {
      _articlesFuture = FirebaseArticleService().fetchFilteredArticles(
        searchQuery: _searchQuery,
      );
    });
  }

  void _resetFilters() {
    setState(() {
      _searchQuery = null;
      _articlesFuture = FirebaseArticleService().fetchArticles();
    });
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
      body: Padding(
        padding: EdgeInsets.only(left: 12.0.h, right: 12.0.h, top: 8.0.h),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 38.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (value) {
                            _searchQuery = value;
                            _updateArticles();
                          },
                          decoration: const InputDecoration(
                            hintText: 'Cari artikel...',
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                6.horizontalSpace,
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: _resetFilters,
                      icon: const Icon(Icons.restore),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: _articlesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Terjadi kesalahan'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/no-data.png',
                            height: 200, // Set the desired height
                          ),
                          const Text('Tidak ada artikel'),
                        ],
                      ),
                    );
                  }

                  List<Article> articles = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    itemCount: articles.length,
                    itemBuilder: (BuildContext context, int index) {
                      Article article = articles[index];
                      return ArticleCard(article: article);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
