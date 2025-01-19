import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab3_211050/models/joke_model.dart';
import 'package:lab3_211050/services/api_services.dart';

class JokeProvider extends ChangeNotifier {
  bool _isObscure = true;

  bool get isObscure => _isObscure;

  final List<Joke> _favoriteJokes = [];
  List<Joke> get favoriteJokes => _favoriteJokes;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  CollectionReference get favoritesJokesList => firebaseFirestore.collection('favorites');

  void toggleVisibility() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  Future<void> toggleFavorite(Joke joke) async {
    // Check if joke is already a favorite
    if (await isFavorite(joke)) {
      // Remove from favorites if it's already there
      await favoritesJokesList.doc(joke.id as String?).delete();
    } else {
      // Add to favorites
      await favoritesJokesList.doc(joke.id as String?).set({
        'joke': joke.id,
      });
    }
    notifyListeners();
  }

  Future<bool> isFavorite(Joke joke) async {
    final jokeDoc = await favoritesJokesList.doc(joke.id as String?).get();
    return jokeDoc.exists;
  }

  Future<List<Joke>> getFavorites() async {
    final document = await favoritesJokesList.get();
    var jokeIds = document.docs.map((toElement) => toElement['joke'] as String).toList();

    final List<Joke> favoriteJokes = [];
    for (var id in jokeIds) {
      final joke = await ApiService.getJokeById(id);
      favoriteJokes.add(joke);
    }

    return favoriteJokes;
  }
}
