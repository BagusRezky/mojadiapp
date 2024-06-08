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
  List<Map<String, dynamic>>
      statusList; // Menggunakan dynamic untuk menyertakan timestamp
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
    required this.statusList,
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
      'status_list': statusList
          .map((status) => Map<String, dynamic>.from(status))
          .toList(),
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
      statusList: List<Map<String, dynamic>>.from((map['status_list'] ?? [])
          .map((status) => Map<String, dynamic>.from(status))),
      timestamp: map['timestamp'] ?? Timestamp.now(),
    );
  }
}
