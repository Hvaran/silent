
import 'package:flutter/material.dart';
import 'journal_service.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({Key? key}) : super(key: key);

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final JournalService _journalService = JournalService();
  final TextEditingController _controller = TextEditingController();
  List<String> entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() async {
    final data = await _journalService.getEntries();
    setState(() {
      entries = data;
    });
  }

  void _addEntry() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      await _journalService.addEntry(text);
      _controller.clear();
      _loadEntries();
    }
  }

  void _deleteEntry(int index) async {
    await _journalService.deleteEntry(index);
    _loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Мій журнал')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Запиши думку або спогад',
                border: OutlineInputBorder(),
              ),
              minLines: 1,
              maxLines: 3,
            ),
          ),
          ElevatedButton(
            onPressed: _addEntry,
            child: const Text('Зберегти запис'),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(entries[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteEntry(index),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
