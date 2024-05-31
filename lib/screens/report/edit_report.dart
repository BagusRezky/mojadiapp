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

class EditReportScreen extends StatefulWidget {
  final Report report;

  const EditReportScreen({super.key, required this.report});

  @override
  State<EditReportScreen> createState() => _EditReportScreenState();
}

class _EditReportScreenState extends State<EditReportScreen> {
  // controller
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _kategoryController = TextEditingController();
  File? _image;
  final ImagePicker _picker = ImagePicker();

  final List<String> categories = [
    'Pelanggaran Lingkungan',
    'Kerusakan Fasilitas Sosial',
    'Kerusakan Jalan',
    'Kerusakan Drainase',
  ];

  @override
  void initState() {
    super.initState();
    _judulController.text = widget.report.judul;
    _deskripsiController.text = widget.report.deskripsi;
    _dateController.text = widget.report.tanggal;
    _lokasiController.text = widget.report.lokasi;
    _kategoryController.text = widget.report.kategori;
  }

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
      initialDate: DateTime.parse(_dateController.text),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> _updateData() async {
    if (_judulController.text.isEmpty ||
        _deskripsiController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _lokasiController.text.isEmpty ||
        _kategoryController.text.isEmpty) {
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
      String imageUrl = widget.report.imageUrl;
      if (_image != null) {
        imageUrl = await FirebaseReportService().uploadImage(_image!);
      }

      Report updatedReport = Report(
        id: widget.report.id,
        judul: _judulController.text,
        deskripsi: _deskripsiController.text,
        tanggal: _dateController.text,
        lokasi: _lokasiController.text,
        kategori: _kategoryController.text,
        imageUrl: imageUrl,
        userEmail: widget.report.userEmail,
        status: widget.report.status,
        timestamp: widget.report.timestamp,
      );

      await FirebaseReportService().updateReport(updatedReport);

      // Close loading indicator
      Navigator.pop(context);

      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Berhasil',
        text: 'Laporan berhasil diperbarui',
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
        text: 'Terjadi kesalahan saat memperbarui laporan',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Laporan',
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
                          border: Border.all(color: Colors.black),
                        ),
                        child: _image == null
                            ? widget.report.imageUrl.isEmpty
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
                                : Image.network(
                                    widget.report.imageUrl,
                                    fit: BoxFit.cover,
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
                      value: _kategoryController.text,
                      onChanged: (String? value) {
                        setState(() {
                          _kategoryController.text = value!;
                        });
                      },
                    ),
                    20.verticalSpace,
                    MyButton(text: 'Update Laporan', onPressed: _updateData),
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
