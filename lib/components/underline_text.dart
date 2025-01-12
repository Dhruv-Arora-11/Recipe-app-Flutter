import 'package:flutter/material.dart';

class UnderlinedText extends StatelessWidget {
  final String text;
  final double thickness;
  final double spacing;
  final TextStyle? style;

  const UnderlinedText({
    Key? key,
    required this.text,
    this.thickness = 2.0,
    this.spacing = 2.0,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: thickness + spacing),
          child: Text(
            text,
            style: style ?? DefaultTextStyle.of(context).style,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: thickness,
            color: style?.color ?? DefaultTextStyle.of(context).style.color,
          ),
        ),
      ],
    );
  }
}
