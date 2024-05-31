import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'dart:io';

class FirebaseReportService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> uploadImage(File image) async {
    String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.png';
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> createReport(Report report) async {
    await _db.collection('reports').add(report.toMap());
  }

  // Fetch all reports
  Future<List<Report>> fetchReports() async {
    QuerySnapshot snapshot = await _db.collection('reports').get();
    return snapshot.docs
        .map(
            (doc) => Report.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> updateReport(Report report) async {
    await _db.collection('reports').doc(report.id).update(report.toMap());
  }

  Future<void> updateReportStatus(String reportId, String newStatus) async {
    await _db.collection('reports').doc(reportId).update({'status': newStatus});
  }

  Future<void> deleteReport(String reportId) async {
    await _db.collection('reports').doc(reportId).delete();
  }
}
