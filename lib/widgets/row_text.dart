import 'package:flutter/material.dart';

class RowText extends StatelessWidget {
  final String leftText;
  final String rightText;
  RowText({Key? key, required this.leftText, required this.rightText})
      : super(key: key);

  final TextStyle style = TextStyle(color: Colors.indigo.shade300);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(leftText, style: style),
        Flexible(
          child: SizedBox(
            width: 130,
            child: Text(
              rightText,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
