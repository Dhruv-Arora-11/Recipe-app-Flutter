import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
    final Color customColor = Color(0xFF0B1520);


  final String title;
  final String hint;
  final TextEditingController controller;
  final bool obsecureText;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  CustomTextField({super.key, 
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
              title,
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
              style: TextStyle(fontSize: 14,color: Colors.white),
              cursorColor: Colors.white,
              obscureText: obsecureText,
              decoration: InputDecoration(
                fillColor: Colors.white,
                hintText: hint,
                hintStyle: TextStyle(fontSize: 14, color: Colors.grey[400]),
                contentPadding: EdgeInsets.only(left: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
