import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/screens/article/components/card_article.home.dart';
import 'package:mojadiapp/screens/report/detail_report.dart';
import 'package:mojadiapp/services/firebase_article_service.dart';
import 'package:mojadiapp/widgets/my_menu.dart';
import 'package:mojadiapp/services/firebase_report_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/screens/report/components/my_report_card.dart';
import 'package:mojadiapp/screens/report/components/my_report_item.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  late Future<List<Report>> _userReportsFuture;
  late Future<List<Article>> _articlesFuture;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _userReportsFuture = _fetchUserReports();
    _articlesFuture = FirebaseArticleService().fetchArticles();
  }

  Future<List<Report>> _fetchUserReports() async {
    User? user = _auth.currentUser;
    if (user != null) {
      return await FirebaseReportService().fetchUserReports(user.email!);
    } else {
      return [];
    }
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Adukan Sekarang!',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                    ],
                  ),
                  10.verticalSpace,
                  ReportCard(context: context),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MyMenu(
                            title: 'Laporan',
                            boxColor: Colors.blue.withOpacity(0.1),
                            iconColor: const Color(0xFF103374),
                            icon: Icons.file_copy,
                            onTap: () {
                              Navigator.pushNamed(context, '/report');
                            },
                          ),
                          MyMenu(
                            title: 'Statistik',
                            boxColor: Colors.red.withOpacity(0.1),
                            iconColor: const Color(0xFFFF3B30),
                            icon: Icons.bar_chart,
                            onTap: () {
                              Navigator.pushNamed(context, '/report');
                            },
                          ),
                          MyMenu(
                            title: 'Artikel',
                            boxColor: Colors.green.withOpacity(0.1),
                            iconColor: const Color(0xFF259F46),
                            icon: Icons.article,
                            onTap: () {
                              Navigator.pushNamed(context, '/article');
                            },
                          ),
                          MyMenu(
                            title: 'Informasi',
                            boxColor: const Color(0xFFF64A4A).withOpacity(0.1),
                            iconColor: const Color(0xFFF64A4A),
                            icon: Icons.info,
                            onTap: () {
                              Navigator.pushNamed(context, '/report');
                            },
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      Text(
                        'Laporanmu!',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                      10.verticalSpace,
                      SizedBox(
                        height: 216.h,
                        child: FutureBuilder<List<Report>>(
                          future: _userReportsFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Terjadi kesalahan'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('Tidak ada laporan'));
                            }

                            List<Report> reports = snapshot.data!;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: reports.length,
                              itemBuilder: (BuildContext context, int index) {
                                Report report = reports[index];
                                String formattedDate = DateFormat('MMM dd')
                                    .format(DateTime.parse(report.tanggal));
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: SizedBox(
                                    width: 253.w,
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
                                                DetailReportScreen(
                                                    report: report),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        'Artikel Terbaru!',
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20.sp,
                        ),
                      ),
                      10.verticalSpace,
                      SizedBox(
                        height: 220.h,
                        child: FutureBuilder<List<Article>>(
                          future: _articlesFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('Terjadi kesalahan'));
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return const Center(
                                  child: Text('Tidak ada laporan'));
                            }

                            List<Article> articles = snapshot.data!;
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: articles.length,
                              itemBuilder: (BuildContext context, int index) {
                                Article article = articles[index];
                                return Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: SizedBox(
                                    width: 253.w,
                                    child: ArticleCardHome(article: article),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: onItemTapped,
      ),
    );
  }
}
