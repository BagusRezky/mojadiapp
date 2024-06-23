import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/pages/home/report/report_detail.dart';
import 'package:mojadiapp/services/firebase_report_service.dart';
import 'package:mojadiapp/pages/home/report/components/my_report_item.dart';

class ListReportScreen extends StatefulWidget {
  const ListReportScreen({super.key});

  @override
  State<ListReportScreen> createState() => _ListReportScreenState();
}

class _ListReportScreenState extends State<ListReportScreen> {
  late Future<List<Report>> _reportsFuture;
  String? _searchQuery;
  String? _selectedCategory;

  final List<String> _categories = [
    'Lingkungan Hidup',
    'Kerusakan Fasilitas Publik',
    'Kerusakan Jalan',
    'Kerusakan Drainase',
    'Keamanan dan Ketertiban',
    'Lainnya'
  ]; // Sesuaikan dengan kategori yang ada

  @override
  void initState() {
    super.initState();
    _reportsFuture = FirebaseReportService().fetchReports();
  }

  void _updateReports() {
    setState(() {
      _reportsFuture = FirebaseReportService().fetchFilteredReports(
        searchQuery: _searchQuery,
        category: _selectedCategory,
      );
    });
  }

  void _resetFilters() {
    setState(() {
      _searchQuery = null;
      _selectedCategory = null;
      _reportsFuture = FirebaseReportService().fetchReports();
    });
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
            height: 1.5.h,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            onPressed: _resetFilters,
          ),
        ],
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
                      height: 38.0.h,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Cari laporan....',
                            prefixIcon: Icon(Icons.search),
                          ),
                          onChanged: (value) {
                            _searchQuery = value;
                            _updateReports();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                6.horizontalSpace,
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ListView(
                            padding: EdgeInsets.all(8.0.h),
                            children: _categories.map((String category) {
                              return ListTile(
                                title: Text(category),
                                onTap: () {
                                  setState(() {
                                    _selectedCategory = category;
                                    _updateReports();
                                    Navigator.pop(context);
                                  });
                                },
                              );
                            }).toList(),
                          );
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
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
                      child: const Icon(Icons.menu_open, color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
            6.verticalSpace,
            Expanded(
              child: FutureBuilder<List<Report>>(
                future: _reportsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Terjadi kesalahan'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/no-data.png',
                            height: 200, // Set the desired height
                          ),
                          const Text('Tidak ada laporan'),
                        ],
                      ),
                    );
                  }

                  List<Report> reports = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
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
          ],
        ),
      ),
    );
  }
}
