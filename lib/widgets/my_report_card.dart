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
          const Opacity(
            opacity: 0.5,
            child: Image(
              image: AssetImage('assets/cover-card.png'),
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  const Color(0xFF1564C0).withOpacity(0.8),
                  const Color(0xFF90CAF8).withOpacity(0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
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
                  color: const Color(0xFF0E47A1),
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
