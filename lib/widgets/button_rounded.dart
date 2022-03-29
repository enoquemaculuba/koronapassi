import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Size? size;
  const RoundedButton(
      {Key? key, required this.onPressed, required this.text, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(), minimumSize: size),
    );
  }
}
