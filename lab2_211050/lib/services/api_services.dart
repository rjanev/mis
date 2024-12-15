import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/joke_model.dart';

class ApiService {
  static Future<List<String>> getJokeTypes() async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/types"));
    if (response.statusCode == 200) {
      List<String> data = List<String>.from(json.decode(response.body));
      print("data $data");
      return data;
    } else {
      throw Exception("Failed to load joke types!");
    }
  }

  static Future<List<dynamic>> getJokesByType(String type) async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/jokes/$type/ten"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((j) => Joke.fromJson(j)).toList();
    } else {
      throw Exception("Failed to load jokes for type $type!");
    }
  }

  static Future<Joke> getRandomJoke() async {
    final response = await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Joke.fromJson(data);
    } else {
      throw Exception("Failed to load random joke!");
    }
  }
}