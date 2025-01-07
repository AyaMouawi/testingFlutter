import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pushnotificationupdate1/Components/register_box.dart';
import 'package:pushnotificationupdate1/Components/token_box.dart';
import 'package:pushnotificationupdate1/Services/register_service.dart';
import 'package:pushnotificationupdate1/Style/my_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;
  String _responseMessage = '';
  bool _isRegistered = false;
  String _errorMessage = '';

  String _firebaseToken = '';

  final RegisterService _registerService = RegisterService();

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  void _getToken() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      setState(() {
        _firebaseToken = token ?? ''; 
      });
      print("Firebase Messaging Token: $token");
    } catch (e) {
      print("Error getting token: $e");
    }
  }

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      try {
        String phoneNumber = _phoneController.text;

        final result = await _registerService.registerUser(phoneNumber);
        final responseBody = result['responseBody'];
        setState(() {
          _isLoading = false;
          if (result['statusCode'] == 200) {
            if (responseBody['code'] == 20000) {
              _responseMessage = 'Registered Successfully';
              _isRegistered = true;
            } else if (responseBody['code'] == 20004) {
              _responseMessage = 'You are already registered';
              _isRegistered = true;
            } else {
              _responseMessage =
                  'An error occurred please contact your administrator';
            }
          } else {
            _errorMessage =
                'An error occurred please contact your administrator';
          }
        });
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error registering user: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: MyColors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            // child: TokenBox(firebaseToken:_firebaseToken , isLoading: _isLoading,)
            child: RegisterBox(
              formKey: _formKey,
              phoneController: _phoneController,
              isLoading: _isLoading,
              responseMessage: _responseMessage,
              isRegistered: _isRegistered,
              errorMessage: _errorMessage,
              registerUser: _registerUser,
            ),
          ),
        ],
      ),
    );
  }
}
