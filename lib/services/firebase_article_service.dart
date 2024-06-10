import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'dart:io';

class FirebaseArticleService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> uploadImage(File image) async {
    String fileName =
        'images/article/${DateTime.now().millisecondsSinceEpoch}.png';
    Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageRef.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }

  Future<void> createArticle(Article article) async {
    await _db.collection('articles').add(article.toMap());
  }

  // Fetch all articles
  Future<List<Article>> fetchArticles() async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('articles')
          .orderBy('timestamp', descending: true)
          .get();
      return snapshot.docs.map((doc) => Article.fromFirestore(doc)).toList();
    } catch (e) {
      print('Error fetching articles: $e');
      rethrow; // Propagate the error to the caller
    }
  }

  Stream<List<Article>> fetchArticlesStream() {
    return _db
        .collection('articles')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Article.fromFirestore(doc)).toList());
  }

  Future<void> updateArticle(Article article) async {
    await _db.collection('articles').doc(article.id).update(article.toMap());
  }

  Future<void> deleteArticle(String articleId) async {
    await _db.collection('articles').doc(articleId).delete();
  }
}
