import 'package:flutter/material.dart';

class JokesTitle extends StatelessWidget {
  final String type;

  const JokesTitle({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        "${type[0].toUpperCase()}${type.substring(1)} jokes",
        style: const TextStyle(
          fontSize: 24,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
