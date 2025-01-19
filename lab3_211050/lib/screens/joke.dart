import 'package:flutter/material.dart';
import '../../models/joke_model.dart';
import '../widgets/j_data.dart';
import '../widgets/j_title.dart';
import 'favourites_screen.dart';

class Jokes extends StatelessWidget {
  const Jokes({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Joke> jokes = ModalRoute.of(context)!.settings.arguments as List<Joke>;
    final String jokeType = jokes.first.type;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        title: JokesTitle(type: jokeType),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.star_border, color: Colors.black), // Changed to black
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white54,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: JokesData(jokes: jokes),
      ),
    );
  }
}
