
import 'package:flutter/material.dart';
import 'chat_service.dart';

class ChatScreen extends StatefulWidget {
  final String apiKey;
  const ChatScreen({required this.apiKey, Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = []; // {'role': 'user'/'bot', 'text': ''}
  bool isLoading = false;
  late ChatService chatService;

  @override
  void initState() {
    super.initState();
    chatService = ChatService(widget.apiKey);
  }

  void sendMessage(String input) async {
    if (input.trim().isEmpty) return;

    setState(() {
      messages.add({'role': 'user', 'text': input});
      isLoading = true;
      _controller.clear();
    });

    try {
      final reply = await chatService.sendMessage(input);
      setState(() {
        messages.add({'role': 'bot', 'text': reply});
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        messages.add({'role': 'bot', 'text': '❌ Помилка: ${e.toString()}'});
        isLoading = false;
      });
    }
  }

  Widget buildMessageBubble(Map<String, String> msg) {
    bool isUser = msg['role'] == 'user';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isUser ? Colors.blue[100] : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(
        msg['text'] ?? '',
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  void handleAnxietyButton() {
    sendMessage("Я почуваюся тривожно. Допоможи мені заспокоїтись.");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Чат підтримки')),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(child: Text('Меню')),
            ListTile(
              title: const Text('Чат підтримки'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // Можна додати інші сторінки тут
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (_, index) =>
                  buildMessageBubble(messages[messages.length - 1 - index]),
            ),
          ),
          if (isLoading) const LinearProgressIndicator(),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Напиши щось...',
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: sendMessage,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => sendMessage(_controller.text),
              ),
              IconButton(
                icon: const Icon(Icons.self_improvement),
                tooltip: 'Я тривожусь',
                onPressed: handleAnxietyButton,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
