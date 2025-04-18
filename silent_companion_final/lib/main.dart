
import 'package:flutter/material.dart';
import 'chat_screen.dart';

void main() {
  runApp(const SilentCompanionApp());
}

class SilentCompanionApp extends StatelessWidget {
  const SilentCompanionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silent Companion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ChatScreen(apiKey: 'your-openai-api-key'),
    );
  }
}
