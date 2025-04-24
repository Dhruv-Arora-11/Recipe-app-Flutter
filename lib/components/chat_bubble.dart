import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isGemini;

  const ChatBubble({super.key, required this.text, required this.isGemini});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isGemini ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: isGemini ? Color(0xFF1B2430) : Color(0xFFEF8354),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isGemini ? Radius.circular(0) : Radius.circular(12),
            bottomRight: isGemini ? Radius.circular(12) : Radius.circular(0),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}