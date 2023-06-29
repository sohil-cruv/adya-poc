import 'dart:ui';

import 'package:flutter/material.dart';

class FeelDialog extends StatelessWidget {
  const FeelDialog({super.key, required this.onHappy, required this.onSad});
  final VoidCallback onHappy;
  final VoidCallback onSad;
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.teal[400]!.withOpacity(0.3),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "How do you feel now? ",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmojiCard(emoji: '😊', name: "Happy", onClick: onHappy),
                  const SizedBox(width: 10),
                  EmojiCard(emoji: '😞', name: "Sad", onClick: onSad)
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Click One Option",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EmojiCard extends StatelessWidget {
  const EmojiCard(
      {super.key,
      required this.emoji,
      required this.name,
      required this.onClick});
  final String emoji;
  final String name;
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        width: 60,
        child: Card(
          color: Colors.teal,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Column(
              children: [
                const Visibility(
                  visible: false,
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  child: Text('name'),
                ),
                Text(
                  emoji,
                  style: const TextStyle(fontSize: 26),
                ),
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
