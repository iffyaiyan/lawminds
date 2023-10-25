import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:lawminds/services/chat.dart';
import 'package:uuid/uuid.dart';

import '../constants/assets.dart';
import '../models/topic.dart';

class ChatProvider with ChangeNotifier {
  final List<Topic> _topics = [
    Topic('Sexual Harassment', 'harassment', Assets.harassment),
    Topic('Bullying', 'bully', Assets.bully),
    Topic('NDA', 'nda', Assets.leave),
    Topic('Office Ethics', 'ethics', Assets.safety),
  ];
  Topic? _selectedTopic;
  final List<types.Message> _messages = [];
  final user = const types.User(id: 'user', firstName: 'You');
  final chatbot = const types.User(id: 'chatbot', firstName: 'Bot');
  bool _isTyping = false;
  String? _sessionId;
  List<String> _suggestions = [];

  List<Topic> get topics => _topics;
  Topic? get selectedTopic => _selectedTopic;
  List<types.Message> get messages => _messages;
  bool get isTyping => _isTyping;
  List<String> get suggestions => _suggestions;

  set isTyping(bool val) {
    _isTyping = val;
    notifyListeners();
  }

  set suggestions(List<String> val) {
    _suggestions = val;
    notifyListeners();
  }

  void initChat(Topic item) {
    _selectedTopic = item;
    startNewSession();
  }

  void addMessage(types.Message message) {
    _messages.insert(0, message);
    notifyListeners();
  }

  void onMessageTap(BuildContext _, types.Message message) async {
    //final index = _messages.indexWhere((element) => element.id == message.id);
  }

  Future<void> onSuggestionPressed(String message) async {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message,
    );

    addMessage(textMessage);

    chatWithStreamEvent(message);
  }

  Future<void> onSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    addMessage(textMessage);

    chatWithStreamEvent(message.text);
  }

  void chatWithStream(String message) {
    isTyping = true;
    String? answer;
    ChatService().chatWithStream(message, _sessionId!, (String dataChunk) {
      if (answer == null) {
        answer = dataChunk;
        final aiMessage = types.TextMessage(
          author: chatbot,
          createdAt: DateTime.now().millisecondsSinceEpoch,
          id: const Uuid().v4(),
          text: answer!,
        );

        addMessage(aiMessage);
      } else {
        answer = '$answer$dataChunk';
        _messages.first = (_messages.first as types.TextMessage).copyWith(text: answer);
        notifyListeners();
      }
    }).catchError((e) {
      final answerMessage = types.TextMessage(
        author: chatbot,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        text: e,
      );
      addMessage(answerMessage);
    }).whenComplete(() => isTyping = false);
  }

  void chatWithStreamEvent(String message) {
    isTyping = true;
    String? answer;
    ChatService().chatWithStreamEvent(message, _sessionId!, (msg, suggestions) {
      if (msg != null) {
        if (answer == null) {
          answer = msg;
          final aiMessage = types.TextMessage(
            author: chatbot,
            createdAt: DateTime.now().millisecondsSinceEpoch,
            id: const Uuid().v4(),
            text: answer!,
          );

          addMessage(aiMessage);
        } else {
          answer = '$answer$msg';
          _messages.first = (_messages.first as types.TextMessage).copyWith(text: answer);
          notifyListeners();
        }
      }

      if (suggestions != null) {
        this.suggestions = suggestions;
      }

    }).whenComplete(() => isTyping = false);
  }

  void startNewSession() {
    _sessionId = const Uuid().v4();
    _messages.clear();
    _suggestions.clear();
    _isTyping = false;
    notifyListeners();
  }
}