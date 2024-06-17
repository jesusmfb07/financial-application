// lib/ui/contact/contact_styles.dart
import 'package:flutter/material.dart';

class ContactStyles {
  static const TextStyle titleTextStyle = TextStyle(
    color: Color(0xFF4EBAE2),
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: Color(0xFF4EBAE2),
    fontSize: 18,
  );

  static const InputDecoration inputDecoration = InputDecoration(
    border: OutlineInputBorder(),
    labelStyle: TextStyle(color: Colors.grey),
  );

  static const EdgeInsetsGeometry formPadding = EdgeInsets.all(16.0);
}
