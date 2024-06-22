import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Statistik extends StatefulWidget {
  const Statistik({super.key});

  @override
  _StatistikState createState() => _StatistikState();
}

class _StatistikState extends State<Statistik> {
  String selectedYear = '2024';
  Map<String, double> categoryData = {};
  Map<int, Map<String, int>> monthlyCounts = {};
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });

    // Fetch data
    await _fetchPieChartData();
    await _fetchBarChartData();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchPieChartData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('reports').get();
    Map<String, int> categoryCounts = {};

    for (var doc in querySnapshot.docs) {
      String category = doc['kategori'];
      categoryCounts[category] = (categoryCounts[category] ?? 0) + 1;
    }

    int total = categoryCounts.values.fold(0, (sum, count) => sum + count);

    setState(() {
      categoryData = categoryCounts
          .map((key, value) => MapEntry(key, (value / total) * 100));
    });
  }

  Future<void> _fetchBarChartData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('reports').get();

    for (var doc in querySnapshot.docs) {
      DateTime date;
      if (doc['tanggal'] is Timestamp) {
        date = (doc['tanggal'] as Timestamp).toDate();
      } else {
        date = DateTime.parse(doc['tanggal']);
      }
      int month = date.month;

      if (doc['status_list'] is List<dynamic>) {
        List<dynamic> statusList = doc['status_list'];

        statusList.sort((a, b) {
          DateTime timeA = (a['timestamp'] as Timestamp).toDate();
          DateTime timeB = (b['timestamp'] as Timestamp).toDate();
          return timeA.compareTo(timeB);
        });

        // Mengambil status terakhir setelah diurutkan
        var lastStatus = statusList.last;
        if (lastStatus is Map<String, dynamic> &&
            lastStatus.containsKey('status')) {
          String statusValue = lastStatus['status'];
          if (!monthlyCounts.containsKey(month)) {
            monthlyCounts[month] = {
              'Belum Selesai': 0,
              'Proses': 0,
              'Selesai': 0
            };
          }
          monthlyCounts[month]![statusValue] =
              (monthlyCounts[month]![statusValue] ?? 0) + 1;
        }
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Statistik',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            height: 1.5.h,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  16.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 160.w,
                        height: 130.h,
                        child: AspectRatio(
                          aspectRatio: 1.2,
                          child: PieChart(
                            PieChartData(
                              sections: _buildSections(),
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 3,
                              centerSpaceRadius: 50,
                            ),
                          ),
                        ),
                      ),
                      16.horizontalSpace,
                      _buildLegend(),
                    ],
                  ),
                  20.verticalSpace,
                  DropdownButton<String>(
                    value: selectedYear,
                    items: <String>['2024', '2025', '2026']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('Tahun: $value'),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedYear = newValue!;
                      });
                    },
                  ),
                  20.verticalSpace,
                  Expanded(
                    child: selectedYear == '2024'
                        ? Column(
                            children: [
                              Expanded(child: _buildBarChart()),
                              10.verticalSpace,
                              _buildBarChartLegend(),
                            ],
                          )
                        : Center(
                            child: Text(
                              "Belum ada grafik untuk tahun yang dipilih",
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    return categoryData.entries.map((entry) {
      return PieChartSectionData(
        value: entry.value,
        color: _getColorForCategory(entry.key),
        title: '${entry.value.toStringAsFixed(0)}%',
        titleStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 12.sp,
        ),
      );
    }).toList();
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Lingkungan Hidup':
        return Colors.green;
      case 'Kerusakan Fasilitas Publik':
        return Colors.blue;
      case 'Kerusakan Jalan':
        return Colors.orange;
      case 'Kerusakan Drainase':
        return Colors.grey;
      case 'Keamanan dan Ketertiban':
        return Colors.purple;
      default:
        return Colors.black;
    }
  }

  Widget _buildLegend() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: categoryData.keys.map((category) {
          return _buildLegendItem(_getColorForCategory(category), category);
        }).toList());
  }

  Widget _buildLegendItem(Color color, String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0.h),
      child: Row(
        children: [
          Container(
            width: 10.w,
            height: 14.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          8.horizontalSpace,
          Text(
            title,
            style: TextStyle(fontSize: 10.sp),
          ),
        ],
      ),
    );
  }

  BarChart _buildBarChart() {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 10,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                return SideTitleWidget(
                  axisSide: meta.axisSide,
                  child: Text(
                    _getMonthName(value.toInt()),
                    style: TextStyle(fontSize: 10.sp),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(value.toInt().toString());
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: _buildBarGroups(),
      ),
    );
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return '';
    }
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(12, (index) {
      int month = index + 1;
      Map<String, int> counts = monthlyCounts[month] ??
          {'Belum Selesai': 0, 'Proses': 0, 'Selesai': 0};
      return BarChartGroupData(
        x: month,
        barRods: [
          BarChartRodData(
            toY: counts['Belum Selesai']?.toDouble() ?? 0,
            color: Colors.red,
            width: 3.sp,
          ),
          BarChartRodData(
            toY: counts['Proses']?.toDouble() ?? 0,
            color: Colors.yellow,
            width: 3.sp,
          ),
          BarChartRodData(
            toY: counts['Selesai']?.toDouble() ?? 0,
            color: Colors.green,
            width: 3.sp,
          ),
        ],
      );
    }).toList();
  }

  Widget _buildBarChartLegend() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLegendItem(Colors.green, 'Selesai'),
          16.horizontalSpace,
          _buildLegendItem(Colors.yellow, 'Proses'),
          16.horizontalSpace,
          _buildLegendItem(Colors.red, 'Belum Selesai'),
        ],
      ),
    );
  }
}
