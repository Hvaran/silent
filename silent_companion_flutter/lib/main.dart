import 'package:flutter/material.dart';

void main() => runApp(SilentCompanionApp());

class SilentCompanionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silent Companion',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedLanguage = 'uk';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedLanguage == 'uk' ? 'Тихий Супутник' : 'Silent Companion'),
        actions: [
          IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              setState(() {
                selectedLanguage = selectedLanguage == 'uk' ? 'en' : 'uk';
              });
            },
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                selectedLanguage == 'uk' ? 'Як ти, брате?' : 'How are you, brother?',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Перехід до чату (пізніше)
                },
                child: Text(selectedLanguage == 'uk' ? 'Почати розмову' : 'Start Conversation'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
