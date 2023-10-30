import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  const FloatingButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed(),
    );
  }
}
