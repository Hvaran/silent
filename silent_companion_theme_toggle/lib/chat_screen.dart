
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'journal_screen.dart';
import 'chat_service.dart';
import 'theme_toggle.dart';

class ChatScreen extends StatelessWidget {
  final String apiKey;
  const ChatScreen({required this.apiKey, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Чат підтримки')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Меню')),
            ListTile(
              title: const Text('Мій журнал'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const JournalScreen()));
              },
            ),
            ListTile(
              title: const Text('Перемкнути тему'),
              onTap: () {
                final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
                themeProvider.toggleTheme();
              },
            ),
          ],
        ),
      ),
      body: const Center(child: Text('Чат тут :)')),
    );
  }
}
