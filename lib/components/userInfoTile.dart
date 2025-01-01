import 'package:flutter/material.dart';

class UserInfoTile extends StatelessWidget {
    final Color customColor = Color(0xFF0B1520);

  final String label, value;
  final EdgeInsetsGeometry margin, padding;
  final Color valueBackground;
  UserInfoTile({required this.label, required this.value, required this.padding,required this.margin,required this.valueBackground});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text('$label', style: TextStyle(color: customColor, fontSize: 12)),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(16),
            color: valueBackground ?? customColor,
            child: Text('$value', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'inter')),
          )
        ],
      ),
    );
  }
}
