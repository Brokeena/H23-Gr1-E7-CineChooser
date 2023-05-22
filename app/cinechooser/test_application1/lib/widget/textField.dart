import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  const BorderSide(color: Colors.transparent), //couleur contour
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
                  BorderSide(color: Colors.grey.shade600), //couleur contour
            ),
            fillColor: Colors.grey.shade900,
            //couleur interieur
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey.shade700),
            contentPadding: EdgeInsets.all(16)),
      ),
    );
  }
}
