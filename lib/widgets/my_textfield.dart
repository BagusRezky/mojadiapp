// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final int minLines;
  final int maxLines;
  final bool obscure;
  TextEditingController controller;

  TextInputField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.minLines,
    required this.maxLines,
    required this.controller,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: 16.sp,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        labelText: labelText,
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
      minLines: minLines,
      maxLines: maxLines,
      obscureText: obscure,
      controller: controller,
    );
  }
}
