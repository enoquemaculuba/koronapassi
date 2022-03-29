import 'package:flutter/material.dart';

class RowTextToggle extends StatefulWidget {
  final String text;
  final Function(bool) onChanged;
  final bool initialValue;
  const RowTextToggle(
      {Key? key,
      required this.text,
      required this.onChanged,
      this.initialValue = true})
      : super(key: key);

  @override
  _RowTextToggleState createState() => _RowTextToggleState();
}

class _RowTextToggleState extends State<RowTextToggle> {
  bool? _value;

  @override
  void initState() {
    _value = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(widget.text),
        Switch(
            value: _value!,
            onChanged: (value) {
              setState(() {
                _value = value;
                widget.onChanged(value);
              });
            })
      ],
    );
  }
}
