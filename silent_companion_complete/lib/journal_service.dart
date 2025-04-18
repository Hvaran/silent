
import 'package:shared_preferences/shared_preferences.dart';

class JournalService {
  static const _key = 'journal_entries';

  Future<List<String>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> addEntry(String entry) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = prefs.getStringList(_key) ?? [];
    entries.add(entry);
    await prefs.setStringList(_key, entries);
  }

  Future<void> deleteEntry(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final entries = prefs.getStringList(_key) ?? [];
    if (index >= 0 && index < entries.length) {
      entries.removeAt(index);
      await prefs.setStringList(_key, entries);
    }
  }
}
