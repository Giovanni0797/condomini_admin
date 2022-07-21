import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'globals.dart';
import 'homepage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        scaffoldBackgroundColor: def,
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          //headline1: TextStyle(color: Colors.deepPurpleAccent),
          //headline2: TextStyle(color: Colors.deepPurpleAccent),
          bodyText2: TextStyle(color: bianco),
          //subtitle1: TextStyle(color: Colors.pinkAccent),
        ),
      ),
    );
  }
}

