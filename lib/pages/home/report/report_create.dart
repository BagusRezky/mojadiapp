// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mojadiapp/models/report_model.dart';
import 'package:mojadiapp/services/firebase_report_service.dart';
import 'package:mojadiapp/widgets/my_button.dart';
import 'package:mojadiapp/widgets/my_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:quickalert/quickalert.dart';

class CreateReportScreen extends StatefulWidget {
  const CreateReportScreen({super.key});

  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  // controller
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();
  String? _selectedCategory;

  final List<String> categories = [
    'Lingkungan Hidup',
    'Kerusakan Fasilitas Publik',
    'Kerusakan Jalan',
    'Kerusakan Drainase',
    'Keamanan dan Ketertiban',
    'Lainnya'
  ];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectedDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _uploadData() async {
    if (_image == null ||
        _judulController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _lokasiController.text.isEmpty ||
        _selectedCategory == null) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Semua field harus diisi',
      );
      return;
    }

    // Show loading indicator
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
      String imageUrl = await FirebaseReportService().uploadImage(_image!);
      final user = FirebaseAuth.instance.currentUser;
      String userEmail = user!.email!;

      Report report = Report(
        id: '',
        judul: _judulController.text,
        deskripsi: _deskripsiController.text,
        tanggal: _dateController.text,
        lokasi: _lokasiController.text,
        kategori: _selectedCategory!,
        imageUrl: imageUrl,
        userEmail: userEmail,
        statusList: [
          {
            'status': 'Belum Selesai',
            'deskripsi': 'Laporan belum dikerjakan',
            'timestamp':
                Timestamp.now(), // Menambahkan timestamp ke status awal
          }
        ], // Status awal
        timestamp: Timestamp.now(),
      );

      await FirebaseReportService().createReport(report);

      setState(() {
        _image = null;
        _judulController.clear();
        _deskripsiController.clear();
        _dateController.clear();
        _lokasiController.clear();
        _selectedCategory = null;
      });

      // Close loading indicator
      Navigator.pop(context);

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Berhasil',
        text: 'Laporan berhasil dibuat',
        onConfirmBtnTap: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
      );
    } catch (e) {
      // Close loading indicator
      Navigator.pop(context);

      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Error',
        text: 'Terjadi kesalahan saat membuat laporan',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buat Laporan',
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
                      hintText: 'Masukkan Judul Laporan',
                      labelText: 'Judul Laporan',
                      controller: _judulController,
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
                    12.verticalSpace,
                    TextField(
                      controller: _dateController,
                      style: TextStyle(
                        fontSize: 16.sp,
                      ),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.calendar_today),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'DD/MM/YYYY',
                        labelText: 'Waktu Laporan',
                        hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                        labelStyle: GoogleFonts.roboto(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFF1564C0),
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      obscureText: false,
                      onTap: () {
                        _selectedDate();
                      },
                    ),
                    12.verticalSpace,
                    TextInputField(
                      hintText: 'Masukkan Lokasi Laporan',
                      labelText: 'Lokasi',
                      controller: _lokasiController,
                      minLines: 1,
                      maxLines: 1,
                    ),
                    12.verticalSpace,
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: 'Kategori Laporan',
                        hintText: 'Pilih Kategori... ',
                        hintStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                        labelStyle: GoogleFonts.roboto(
                          color: Colors.black,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Colors.black,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: Color(0xFF1564C0),
                          ),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      items: categories
                          .map((String value) => DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              ))
                          .toList(),
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    20.verticalSpace,
                    MyButton(text: 'Buat Laporan', onPressed: _uploadData),
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
