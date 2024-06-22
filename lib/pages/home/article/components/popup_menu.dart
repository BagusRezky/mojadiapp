import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/pages/home/article/article_edit.dart';
import 'package:quickalert/quickalert.dart';

class ArticlePopupMenu extends StatelessWidget {
  final Article article;
  final Function onDelete;

  const ArticlePopupMenu({
    super.key,
    required this.article,
    required this.onDelete,
  });

  void _deleteArticle(BuildContext context) async {
    onDelete();
  }

  void _showNotAuthorizedAlert(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Tidak Diizinkan',
      text: 'Anda tidak diizinkan untuk melakukan aksi ini.',
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    bool isOwner = user != null && user.email == article.userEmail;

    return PopupMenuButton<String>(
      color: Colors.white,
      icon: const Icon(Icons.more_vert, color: Colors.black),
      onSelected: (String result) {
        if (!isOwner) {
          _showNotAuthorizedAlert(context);
          return;
        }
        switch (result) {
          case 'Edit Artikel':
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditArticleScreen(article: article)));
            break;
        }
        switch (result) {
          case 'Delete Artikel':
            _deleteArticle(context);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Edit Artikel',
          child: Text('Edit Artikel'),
        ),
        const PopupMenuItem<String>(
          value: 'Delete Artikel',
          child: Text('Delete Artikel'),
        ),
      ],
    );
  }
}
