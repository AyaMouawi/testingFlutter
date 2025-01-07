import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';

class RegisterService {
  static const String _url = 'https://test7.apliman.com/push_api/register/v1/';

  Future<Map<String, dynamic>> registerUser(String phoneNumber) async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      final payload = {
        "projectId": "pushnotificationupdate1",
        "msisdn": phoneNumber,
        "userId": token,
      };

      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(payload),
      );

      final responseBody = json.decode(response.body);
      return {
        'statusCode': response.statusCode,
        'responseBody': responseBody,
      };
    } catch (e) {
      print("Error registering user: $e");
      return {'statusCode': 500, 'error': e.toString()};
    }
  }
}
