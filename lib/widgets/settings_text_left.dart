import 'package:flutter/material.dart';

class LeftText extends StatelessWidget {
  final String text;
  final double? textSize;
  final FontWeight? fontWeight;
  const LeftText(
      {Key? key,
      required this.text,
      this.textSize = 20,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: TextStyle(fontSize: textSize, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
