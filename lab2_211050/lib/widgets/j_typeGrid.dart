import 'package:flutter/material.dart';
import 'j_type_card.dart';

class JokeTypesGrid extends StatelessWidget {
  final List<String> jokeTypes;

  const JokeTypesGrid({super.key, required this.jokeTypes});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.9,
      ),
      itemCount: jokeTypes.length,
      itemBuilder: (context, index) => JokeTypeCard(type: jokeTypes[index]),
    );
  }
}
