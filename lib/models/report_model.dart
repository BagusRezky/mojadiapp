import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  String id;
  String judul;
  String deskripsi;
  String tanggal;
  String lokasi;
  String kategori;
  String imageUrl;
  String userEmail;
  String status;
  Timestamp timestamp;

  Report({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.tanggal,
    required this.lokasi,
    required this.kategori,
    required this.imageUrl,
    required this.userEmail,
    this.status = 'Belum Selesai',
    required this.timestamp,
  });

  // Convert a Report object into a Map object
  Map<String, dynamic> toMap() {
    return {
      'judul': judul,
      'deskripsi': deskripsi,
      'tanggal': tanggal,
      'lokasi': lokasi,
      'kategori': kategori,
      'image_url': imageUrl,
      'user_email': userEmail,
      'status': status,
      'timestamp': timestamp,
    };
  }

  // Create a Report object from a Map object
  factory Report.fromMap(Map<String, dynamic> map, String documentId) {
    return Report(
      id: documentId,
      judul: map['judul'] ?? '',
      deskripsi: map['deskripsi'] ?? '',
      tanggal: map['tanggal'] ?? '',
      lokasi: map['lokasi'] ?? '',
      kategori: map['kategori'] ?? '',
      imageUrl: map['image_url'] ?? '',
      userEmail: map['user_email'] ?? '',
      status: map['status'] ?? 'Belum Selesai',
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }
}
