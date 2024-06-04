import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportCard extends StatelessWidget {
  final BuildContext context;

  const ReportCard({
    Key? key,
    required this.context,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Ink.image(
            image: const AssetImage('assets/coverr.jpeg'),
            height: 180,
            fit: BoxFit.cover,
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.withOpacity(0.7), Colors.transparent],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
            ),
          ),
          Positioned(
            top: 16,
            right: 30,
            left: 16,
            child: Text(
              'Yuk, laporkan temuaan pelanggaran & kerusakan fasilitas sosial',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.normal,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            top: 70,
            right: 30,
            left: 16,
            child: Text(
              'di Lingkungan Sekitarmu!',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            width: 140,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/report/create');
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Buat Laporan',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
