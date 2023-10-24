import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  final String _name = 'John Doe';

  String get name => _name;
}