import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
    final Color customColor = Color(0xFF0B1520);


  final String title;
  final String hint;
  final TextEditingController controller;
  final bool obsecureText;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  CustomTextField({
    required this.title,
    required this.hint,
    required this.controller,
    required this.obsecureText,
    required this.padding,
    required this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8),
            child: Text(
              '$title',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(color: customColor, borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 14),
              cursorColor: customColor,
              obscureText: obsecureText,
              decoration: InputDecoration(
                hintText: '$hint',
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                contentPadding: EdgeInsets.only(left: 16),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
