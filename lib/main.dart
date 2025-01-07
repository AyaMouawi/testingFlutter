import 'package:flutter/material.dart';
import 'package:pushnotificationupdate1/Pages/register_page.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data in foreground: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    runApp(const MyApp());
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
}

Future backgroundHandler(RemoteMessage message) async {
  print('Message data in background: ${message.data}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aiReach Push Notification Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const RegisterPage(),
    );
  }
}
