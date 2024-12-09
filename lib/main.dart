import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';
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
  print('Message data in background : ${message.data}');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _token = 'Fetching token...';

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  void _getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      print("Firebase Messaging Token: $token");
      setState(() {
        _token = token ?? 'Failed to get token';
      });
    } catch (e) {
      print("Error getting token: $e");
       setState(() {
        _token = 'Error getting token: $e';
      });
    }
  }



 void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _token)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Token copied to clipboard!')),
      );
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            const Text(
              'Firebase Messaging Token:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                _token,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blue),
              ),
            ),
              const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _copyToClipboard,  
              child: const Text('Copy Token'),
            ),
          ],
        ),
      ),
     
    );
  }
}
