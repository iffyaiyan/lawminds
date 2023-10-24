import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/chat.dart';
import 'topic_item.dart';

class TopicWidget extends StatelessWidget {
  const TopicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("We're here to provide legal guidance on workplace conflicts and issues.\nPlease select a topic to start chatting and get the help you need."),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 10,
          ),
          itemCount: context.watch<ChatProvider>().topics.length,
          itemBuilder: (context, index) {
            return TopicItem(item: context.watch<ChatProvider>().topics[index]);
          },
        )
      ],
    );
  }
}
