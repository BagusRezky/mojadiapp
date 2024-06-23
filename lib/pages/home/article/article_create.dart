// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mojadiapp/models/article_model.dart';
import 'package:mojadiapp/services/firebase_article_service.dart';
import 'package:mojadiapp/widgets/my_button.dart';
import 'package:mojadiapp/widgets/my_textfield.dart';
import 'package:quickalert/quickalert.dart';

class CreateArticleScreen extends StatefulWidget {
  const CreateArticleScreen({super.key});

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  // controller
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadData() async {
    if (_image == null ||
        _titleController.text.isEmpty ||
        _deskripsiController.text.isEmpty) {
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
      // upload image
      String imageUrl = await FirebaseArticleService().uploadImage(_image!);
      // username of the current user
      final user = FirebaseAuth.instance.currentUser;
      String userEmail = user!.email!;

      // upload data
      Article article = Article(
        id: '',
        imageUrl: imageUrl,
        title: _titleController.text,
        description: _deskripsiController.text,
        userEmail: userEmail,
        timestamp: Timestamp.now(),
      );

      await FirebaseArticleService().createArticle(article);

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
        text: 'Artikel berhasil ditambahkan',
        onConfirmBtnTap: () {
          Navigator.pushNamed(context, '/home');
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
        text: 'Gagal menambahkan artikel $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buat Artikel',
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
                          // border: Border.all(color: Colors.black),
                        ),
                        child: _image == null
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
                            : Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    12.verticalSpace,
                    TextInputField(
                      hintText: 'Masukkan Judul Artikel',
                      labelText: 'Judul Artikel',
                      controller: _titleController,
                      minLines: 1,
                      maxLines: 1,
                      obscure: false,
                    ),
                    12.verticalSpace,
                    TextInputField(
                      hintText: 'Masukkan Deskripsi Artikel',
                      labelText: 'Deskripsi Artikel',
                      controller: _deskripsiController,
                      minLines: 3,
                      maxLines: 5,
                      obscure: false,
                    ),
                    20.verticalSpace,
                    MyButton(text: 'Buat Artikel', onPressed: _uploadData),
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
