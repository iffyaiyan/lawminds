import 'package:flutter/material.dart';

import '../constants/assets.dart';
import '../models/topic.dart';

class ChatProvider with ChangeNotifier {
  final List<Topic> _topics = [
    Topic('Sexual Harassment', 'harassment', Assets.harassment),
    Topic('Bullying', 'bully', Assets.bully),
    Topic('Garden Leave', 'termination', Assets.leave),
    Topic('Workplace Safety', 'safety', Assets.safety),
  ];

  List<Topic> get topics => _topics;
}