import 'package:flutter/material.dart';
import '../services/api_services.dart';
import '../widgets/j_typeGrid.dart';
import 'favourites_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> jokeTypes = [];

  @override
  void initState() {
    super.initState();
    getJokeTypesFromAPI();
  }

  void getJokeTypesFromAPI() async {
    List<String> types = await ApiService.getJokeTypes();
    setState(() {
      jokeTypes = types;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        leading: IconButton(
          onPressed: () {
            // Navigate to random joke page or perform random joke action
            Navigator.pushNamed(context, "/random_joke");
          },
          icon: const Icon(
            Icons.shuffle, // Changed to shuffle icon for random
            color: Colors.black,
            size: 36,
          ),
        ),
        title: const Text(
          "211050",
          style: TextStyle(
            color: Colors.black,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
              size: 24,
            ),
          ),
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
      body: JokeTypesGrid(jokeTypes: jokeTypes),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Share',
        backgroundColor: Colors.green[50],
        child: const Icon(Icons.share_rounded),
      ),
    );
  }
}
