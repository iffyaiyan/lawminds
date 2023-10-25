import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import '../../providers/chat.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 10,
        foregroundColor: Colors.white,
        title: Text(context.watch<ChatProvider>().selectedTopic?.title ?? ''),
        actions: [
          IconButton(onPressed: () => context.read<ChatProvider>().startNewSession(), icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Chat(
        messages: context.watch<ChatProvider>().messages,
        onMessageTap: context.read<ChatProvider>().onMessageTap,
        onPreviewDataFetched: context.read<ChatProvider>().onPreviewDataFetched,
        onSendPressed: context.read<ChatProvider>().onSendPressed,
        showUserAvatars: true,
        showUserNames: true,
        user: context.watch<ChatProvider>().user,
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: [if (context.watch<ChatProvider>().isTyping) context.read<ChatProvider>().chatbot],
        ),
        inputOptions: InputOptions(enabled: !context.watch<ChatProvider>().isTyping),
      ),
    );
  }
}