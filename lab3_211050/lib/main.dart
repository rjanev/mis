import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lab3_211050/provider/joke_provider.dart';
import 'package:lab3_211050/screens/home.dart';
import 'package:lab3_211050/screens/joke.dart';
import 'package:lab3_211050/screens/random_joke.dart';
import 'package:lab3_211050/services/notifications_service.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationsService().initialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => JokeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Clothes App',
      theme: ThemeData(primarySwatch: Colors.grey),
      initialRoute: "/home",
      routes: {
        "/home": (context) => const Home(),
        "/jokes": (context) => const Jokes(),
        "/random_joke": (context) => const RandomJoke(),
      },
    );
  }
}