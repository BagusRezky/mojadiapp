import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/services/firebase_article_service.dart';
import 'package:mojadiapp/widgets/my_button.dart';
import 'package:mojadiapp/widgets/my_textfield.dart';
import 'package:quickalert/quickalert.dart';

class EditArticleScreen extends StatefulWidget {
  final Article article;

  const EditArticleScreen({super.key, required this.article});

  @override
  State<EditArticleScreen> createState() => _EditArticleScreenState();
}

class _EditArticleScreenState extends State<EditArticleScreen> {
  // controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.article.title;
    _deskripsiController.text = widget.article.description;
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateData() async {
    if (_titleController.text.isEmpty || _deskripsiController.text.isEmpty) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Semua field harus diisi',
      );
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // upload image if a new one is picked
      String imageUrl = widget.article.imageUrl;
      if (_image != null) {
        imageUrl = await FirebaseArticleService().uploadImage(_image!);
      }

      // upload data
      Article updatedArticle = Article(
        id: widget.article.id,
        imageUrl: imageUrl,
        title: _titleController.text,
        description: _deskripsiController.text,
        userEmail: widget.article.userEmail,
        timestamp: widget.article.timestamp,
      );

      await FirebaseArticleService().updateArticle(updatedArticle);

      // clear the form
      setState(() {
        _image = null;
        _titleController.clear();
        _deskripsiController.clear();
      });

      // Close loading indicator
      Navigator.pop(context);

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Berhasil',
        text: 'Artikel berhasil diperbarui',
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      // Close loading indicator
      Navigator.pop(context);

      // Show error message
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Gagal memperbarui artikel $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Artikel',
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w600, fontSize: 24.sp, height: 36.sp),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _pickImage(ImageSource.gallery),
                      child: Container(
                        width: double.infinity,
                        height: 150.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: _image == null
                            ? widget.article.imageUrl.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_alt,
                                          color: Colors.grey[800]),
                                      5.verticalSpace,
                                      Text(
                                        'Upload Image',
                                        style: GoogleFonts.roboto(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.sp,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  )
                                : Image.network(widget.article.imageUrl,
                                    fit: BoxFit.cover)
                            : Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    12.verticalSpace,
                    TextInputField(
                      hintText: 'Masukkan Judul Laporan',
                      labelText: 'Judul Laporan',
                      controller: _titleController,
                      minLines: 1,
                      maxLines: 1,
                      obscure: false,
                    ),
                    12.verticalSpace,
                    TextInputField(
                      hintText: 'Masukkan Deskripsi Laporan',
                      labelText: 'Deskripsi Laporan',
                      controller: _deskripsiController,
                      minLines: 3,
                      maxLines: 5,
                      obscure: false,
                    ),
                    20.verticalSpace,
                    MyButton(text: 'Perbarui Artikel', onPressed: _updateData),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
