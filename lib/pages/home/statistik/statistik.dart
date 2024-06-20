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

  @override
  void initState() {
    super.initState();
    _fetchPieChartData();
    _fetchBarChartData();
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
        for (var status in statusList) {
          if (status is Map<String, dynamic> && status.containsKey('status')) {
            String statusValue = status['status'];
            if (!monthlyCounts.containsKey(month)) {
              monthlyCounts[month] = {
                'Belum Mulai': 0,
                'Proses': 0,
                'Selesai': 0
              };
            }
            monthlyCounts[month]![statusValue] =
                (monthlyCounts[month]![statusValue] ?? 0) + 1;
          }
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
            height: 1.5,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 180,
                  height: 150,
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
                const SizedBox(width: 20),
                _buildLegend(),
              ],
            ),
            const SizedBox(height: 30),
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
            const SizedBox(height: 20),
            Expanded(
              child: selectedYear == '2024'
                  ? _buildBarChart()
                  : const Center(
                      child: Text(
                        "Belum ada grafik untuk tahun yang dipilih",
                        style: TextStyle(fontSize: 16),
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
        title: '${entry.value.toStringAsFixed(1)}%',
        titleStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      );
    }).toList();
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Pelanggaran Lingkungan':
        return Colors.blue;
      case 'Kerusakan Fasilitas Sosial':
        return Colors.green;
      case 'Kerusakan Jalan':
        return Colors.orange;
      case 'Kerusakan Drainase':
        return Colors.grey;
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
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 14,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(fontSize: 10),
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
                switch (value.toInt()) {
                  case 1:
                    return Text('Jan');
                  case 2:
                    return Text('Feb');
                  case 3:
                    return Text('Mar');
                  case 4:
                    return Text('Apr');
                  case 5:
                    return Text('May');
                  case 6:
                    return Text('Jun');
                  case 7:
                    return Text('Jul');
                  case 8:
                    return Text('Aug');
                  case 9:
                    return Text('Sep');
                  case 10:
                    return Text('Oct');
                  case 11:
                    return Text('Nov');
                  case 12:
                    return Text('Dec');
                  default:
                    return Text('');
                }
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

  List<BarChartGroupData> _buildBarGroups() {
    return monthlyCounts.entries.map((entry) {
      int month = entry.key;
      Map<String, int> counts = entry.value;

      return BarChartGroupData(
        x: month,
        barRods: [
          BarChartRodData(
            toY: counts['Belum Mulai']?.toDouble() ?? 0,
            color: Colors.red,
          ),
          BarChartRodData(
            toY: counts['Proses']?.toDouble() ?? 0,
            color: Colors.yellow,
          ),
          BarChartRodData(
            toY: counts['Selesai']?.toDouble() ?? 0,
            color: Colors.green,
          ),
        ],
      );
    }).toList();
  }
}
