import 'package:flutter/material.dart';

class CardTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final BorderRadius? borderRadius;
  const CardTextButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        borderRadius: borderRadius,
        onTap: onPressed,
        child: SizedBox(
            width: double.infinity,
            height: 60,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    text,
                  ),
                ))));
  }
}
