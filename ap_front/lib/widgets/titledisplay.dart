import 'package:flutter/material.dart';

class TitleDisplayWidget extends StatelessWidget {
  final String title;

  const TitleDisplayWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    ColorScheme scheme = Theme.of(context).colorScheme;

    return Container(
      width: 290.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: scheme.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12.0,
          vertical: 12.0,
        ), // Adds padding to the right and left
        child: Center(
          child: Text(title, style: theme.displaySmall),
        ),
      ),
    );
  }
}
