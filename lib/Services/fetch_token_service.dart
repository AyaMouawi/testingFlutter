import 'package:firebase_messaging/firebase_messaging.dart';

Future<String> fetchFirebaseToken() async {
  try {
    final String? token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      return token;
    } else {
      return 'No token available';
    }
  } catch (error) {
    return 'Error fetching token';
  }
}
