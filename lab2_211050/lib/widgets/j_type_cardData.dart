import 'package:flutter/material.dart';

class JokeTypeCardData extends StatelessWidget {
  final String type;

  const JokeTypeCardData({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "${type[0].toUpperCase()}${type.substring(1)}",
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
