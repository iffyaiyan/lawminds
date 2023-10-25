import 'package:flutter/material.dart';

class SuggestionItem extends StatelessWidget {
  final String item;
  final VoidCallback onTap;
  const SuggestionItem({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(30),
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black38,
            ),
            child: Text(item, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
