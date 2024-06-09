import 'package:flutter/material.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/screens/article/edit_article.dart';

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

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      icon: const Icon(Icons.more_vert, color: Colors.black),
      onSelected: (String result) {
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
