import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netone_enquiry_management/constants/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    required this.controller,
    required this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.dmSans(
          color: Colors.black,
          height: 0.5,
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: primary, width: 1.0),
        ),
      ),
      style: GoogleFonts.dmSans(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
      ),
      validator: validator,
    );
  }
}
