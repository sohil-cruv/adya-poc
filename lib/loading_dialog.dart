import 'dart:ui';

import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Dialog(
        backgroundColor: Colors.teal[400]!.withOpacity(0.3),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 22),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Understanding your emotion...",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              LinearProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
