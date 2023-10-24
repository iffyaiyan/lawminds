import 'package:flutter/material.dart';
import 'package:lawminds/models/topic.dart';
import 'package:lawminds/providers/chat.dart';
import 'package:lawminds/utils/routes.dart';
import 'package:provider/provider.dart';

class TopicItem extends StatelessWidget {
  final Topic item;
  const TopicItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            context.read<ChatProvider>().initChat(item);
            Navigator.pushNamed(context, Routes.chat);
          },
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(item.asset, fit: BoxFit.cover),
              ),
              const Divider(thickness: 0.5),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Text(item.title, textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
