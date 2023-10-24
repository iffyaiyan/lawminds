import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../constants/assets.dart';
import '../models/topic.dart';

class ChatProvider with ChangeNotifier {
  final List<Topic> _topics = [
    Topic('Sexual Harassment', 'harassment', Assets.harassment),
    Topic('Bullying', 'bully', Assets.bully),
    Topic('Garden Leave', 'termination', Assets.leave),
    Topic('Workplace Safety', 'safety', Assets.safety),
  ];
  Topic? _selectedTopic;
  final List<types.Message> _messages = [];
  final user = const types.User(id: 'user', firstName: 'You');

  List<Topic> get topics => _topics;
  Topic? get selectedTopic => _selectedTopic;
  List<types.Message> get messages => _messages;

  set selectedTopic(Topic? val) {
    _selectedTopic = val;
    notifyListeners();
  }

  String get randomString {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void loadMessages() async {

  }

  void addMessage(types.Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }

  void onMessageTap(BuildContext _, types.Message message) async {
    if (message is types.FileMessage) {
      if (message.uri.startsWith('http')) {
        try {
          final index =
          _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: true,
          );

          _messages[index] = updatedMessage;
          notifyListeners();

        } finally {
          final index = _messages.indexWhere((element) => element.id == message.id);
          final updatedMessage =
          (_messages[index] as types.FileMessage).copyWith(
            isLoading: null,
          );

          _messages[index] = updatedMessage;
          notifyListeners();
        }
      }
    }
  }

  void onPreviewDataFetched(
      types.TextMessage message,
      types.PreviewData previewData,
      ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (_messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    _messages[index] = updatedMessage;
    notifyListeners();
  }

  void onSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString,
      text: message.text,
    );

    addMessage(textMessage);
  }
}