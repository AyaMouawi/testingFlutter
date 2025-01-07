import 'package:flutter/material.dart';

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subHeading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle responseMessageSuccess = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );

  static const TextStyle responseMessageError = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );

  static const TextStyle tokenStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );
}
