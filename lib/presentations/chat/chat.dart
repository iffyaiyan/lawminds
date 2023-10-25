import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:provider/provider.dart';

import '../../providers/chat.dart';
import '../../utils/routes.dart';
import 'widget/suggestion_item.dart';

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
        leading: IconButton(
            onPressed: () => Navigator.pushReplacementNamed(context, Routes.dashboard),
            icon: const Icon(Icons.arrow_back_ios_new)
        ),
        backgroundColor: Colors.black,
        elevation: 10,
        foregroundColor: Colors.white,
        title: Text(context.watch<ChatProvider>().selectedTopic?.title ?? 'Consult'),
        actions: [
          IconButton(onPressed: () => context.read<ChatProvider>().startNewSession(), icon: const Icon(Icons.refresh)),
        ],
      ),
      body: Chat(
        messages: context.watch<ChatProvider>().messages,
        onSendPressed: context.read<ChatProvider>().onSendPressed,
        showUserAvatars: true,
        showUserNames: true,
        user: context.watch<ChatProvider>().user,
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: [if (context.watch<ChatProvider>().isTyping) context.read<ChatProvider>().chatbot],
        ),
        customBottomWidget: _bottomWidget(),
      ),
    );
  }

  Widget _bottomWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (context.watch<ChatProvider>().suggestions.isNotEmpty) ...[
          const SizedBox(height: 5),
          SizedBox(
            height: 50,
            child: ListView.builder(
                padding: const EdgeInsets.only(right: 8),
                itemCount: context.watch<ChatProvider>().suggestions.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return SuggestionItem(
                    item: context.watch<ChatProvider>().suggestions[index],
                    onTap: () => context.read<ChatProvider>().onSuggestionPressed(context.read<ChatProvider>().suggestions[index]),
                  );
                }
            ),
          ),
        ],
        Input(
          onSendPressed: context.read<ChatProvider>().onSendPressed,
          options: InputOptions(enabled: !context.watch<ChatProvider>().isTyping),
        ),
      ],
    );
  }
}