import 'package:flutter/material.dart';

import '../../models/joke_model.dart';

class JokesData extends StatelessWidget {
  final List<Joke> jokes;

  const JokesData({super.key, required this.jokes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jokes.length,
      itemBuilder: (context, index) {
        final joke = jokes[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                joke.setup,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                joke.punchline,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}