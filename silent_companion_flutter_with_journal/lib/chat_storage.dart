import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ChatStorage {
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/chat_history.json';
  }

  Future<List<Map<String, String>>> readMessages() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      if (!await file.exists()) return [];
      String contents = await file.readAsString();
      List<dynamic> jsonData = json.decode(contents);
      return jsonData.cast<Map<String, String>>();
    } catch (e) {
      return [];
    }
  }

  Future<void> writeMessages(List<Map<String, String>> messages) async {
    final path = await _getFilePath();
    final file = File(path);
    await file.writeAsString(json.encode(messages));
  }
}
