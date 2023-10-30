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
      height: 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
        color: scheme.primary,
      ),
      child: Center(
        child: Text(title, style: theme.displaySmall),
      ),
    );
  }
}
