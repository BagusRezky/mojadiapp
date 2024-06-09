import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  String id;
  String imageUrl;
  String title;
  String description;
  String userEmail;
  Timestamp timestamp;

  Article({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.userEmail,
    required this.timestamp,
  });

  factory Article.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return Article(
      id: doc.id,
      imageUrl: data['imageUrl'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      userEmail: data['user_email'] ?? '',
      timestamp: data['timestamp'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'title': title,
      'description': description,
      'user_email': userEmail,
      'timestamp': timestamp,
    };
  }

  static fromMap(Map<String, dynamic> data, String id) {}
}
