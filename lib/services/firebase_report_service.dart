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
    try {
      QuerySnapshot snapshot = await _db
          .collection('reports')
          .orderBy('timestamp', descending: true)
          .get();
      return snapshot.docs
          .map((doc) =>
              Report.fromMap(doc.data() as Map<String, dynamic>, doc.id))
          .toList();
    } catch (e) {
      print('Error fetching reports: $e');
      rethrow; // Propagate the error to the caller
    }
  }

  Future<List<Report>> fetchFilteredReports(
      {String? searchQuery, String? category}) async {
    Query query =
        _db.collection('reports').orderBy('timestamp', descending: true);

    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query
          .where('judul', isGreaterThanOrEqualTo: searchQuery)
          .where('judul', isLessThanOrEqualTo: '$searchQuery\uf8ff');
    }

    if (category != null && category.isNotEmpty) {
      query = query.where('kategori', isEqualTo: category);
    }

    QuerySnapshot snapshot = await query.get();
    return snapshot.docs
        .map(
            (doc) => Report.fromMap(doc.data() as Map<String, dynamic>, doc.id))
        .toList();
  }

  Future<void> updateReport(Report report) async {
    DocumentReference reportRef = _db.collection('reports').doc(report.id);
    DocumentSnapshot reportSnapshot = await reportRef.get();
    if (reportSnapshot.exists) {
      Map<String, dynamic> existingData =
          reportSnapshot.data() as Map<String, dynamic>;
      List<Map<String, dynamic>> existingStatusList =
          List<Map<String, dynamic>>.from(existingData['status_list']);

      // Update report data while preserving existing status_list
      Map<String, dynamic> updatedData = report.toMap();
      updatedData['status_list'] = existingStatusList;

      await reportRef.update(updatedData);
    } else {
      await reportRef.set(report.toMap());
    }
  }

  Future<void> updateReportStatus(
      String reportId, String newStatus, String newStatusDeskripsi) async {
    try {
      DocumentReference reportRef =
          FirebaseFirestore.instance.collection('reports').doc(reportId);
      DocumentSnapshot reportSnapshot = await reportRef.get();
      if (reportSnapshot.exists) {
        List<Map<String, dynamic>> statusList = List<Map<String, dynamic>>.from(
            (reportSnapshot['status_list'] as List)
                .map((status) => Map<String, dynamic>.from(status)));
        statusList.add({
          'status': newStatus,
          'deskripsi': newStatusDeskripsi,
          'timestamp': Timestamp.now(), // Menambahkan timestamp ke status
        });
        await reportRef.update({'status_list': statusList});
      }
    } catch (e) {
      print('Failed to update status: $e');
      throw e; // Lempar kesalahan ke atas agar bisa ditangani di UI
    }
  }

  Future<void> deleteReport(String reportId) async {
    await _db.collection('reports').doc(reportId).delete();
  }

  Stream<List<Report>> fetchUserReportsStream(String userEmail) {
    return _db
        .collection('reports')
        .where('user_email', isEqualTo: userEmail)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Report.fromMap(doc.data(), doc.id))
            .toList());
  }

  Stream<Report> fetchReportStream(String reportId) {
    return _db.collection('reports').doc(reportId).snapshots().map((snapshot) =>
        Report.fromMap(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }
}
