import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:lawminds/services/chat.dart';

import '../constants/assets.dart';
import '../models/topic.dart';

class ChatProvider with ChangeNotifier {
  final List<Topic> _topics = [
    Topic('Sexual Harassment', 'harassment', Assets.harassment),
    Topic('Bullying', 'bully', Assets.bully),
    Topic('Garden Leave', 'termination', Assets.leave),
    Topic('Office Ethics', 'ethics', Assets.safety),
  ];
  Topic? _selectedTopic;
  final List<types.Message> _messages = [];
  final user = const types.User(id: 'user', firstName: 'You');
  final chatbot = const types.User(id: 'chatbot', firstName: 'Bot');
  bool _isTyping = false;

  List<Topic> get topics => _topics;
  Topic? get selectedTopic => _selectedTopic;
  List<types.Message> get messages => _messages;
  bool get isTyping => _isTyping;

  set isTyping(bool val) {
    _isTyping = val;
    notifyListeners();
  }

  String get randomString {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  void initChat(Topic item) {
    _selectedTopic = item;
    _messages.clear();
    notifyListeners();
  }

  void loadMessages() {}

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

  Future<void> onSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString,
      text: message.text,
    );

    addMessage(textMessage);

    isTyping = true;
    ChatService().getAnswer(message.text).then((value) {
      final answerMessage = types.TextMessage(
        author: chatbot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString,
        text: value,
      );

      addMessage(answerMessage);
      isTyping = false;
    }).catchError((_) {
      final answerMessage = types.TextMessage(
        author: chatbot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString,
        text: 'An error occurred.',
      );
      addMessage(answerMessage);
      isTyping = false;
    });
  }
}