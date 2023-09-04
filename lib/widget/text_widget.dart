import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  TextWidget(
      {super.key,
      required this.text,
      required this.textSize,
      required this.maxLines,
      required this.color,
      this.isText = false,
      this.isunderline = false});

  final String text;
  final double textSize;
  bool isText;
  bool isunderline;
  final int maxLines;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: textSize,
        color: color,
        fontWeight: isText ? FontWeight.bold : FontWeight.normal,
        overflow: TextOverflow.ellipsis,
        decoration:
            isunderline ? TextDecoration.lineThrough : TextDecoration.none,
      ),
    );
  }
}
