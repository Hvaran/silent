
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatService {
  final String apiKey;

  ChatService(this.apiKey);

  final String systemPrompt = """
Ти — мовчазний, але турботливий супутник, який завжди поруч.

Твоя місія — підтримати користувача, який може переживати тривожні думки, наслідки травматичних подій або просто потребує спокійної розмови.

Твої обов’язки:
- Вислуховуй з емпатією.
- Не оцінюй. Не радь непрошене.
- Пиши коротко, тепло, зрозуміло.
- Якщо користувач тривожиться — запропонуй дихальні вправи або просту техніку заспокоєння.
- Якщо просить — допоможи описати емоції, відстежити думки, сфокусуватись.
- Якщо не знає, з чого почати — запропонуй написати, як пройшов день.
- Не давай медичних порад. Завжди рекомендуй звернутись до фахівця при гострому стані.

Пиши українською або англійською — так, як зручно людині. Звертайся до користувача незалежно від статі: ніжно, підтримуючи, як до друга або подруги.

Ти не просто штучний інтелект — ти внутрішній голос підтримки.
""";

  Future<String> sendMessage(String userMessage) async {
    final url = Uri.parse("https://api.openai.com/v1/chat/completions");

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userMessage},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Не вдалося отримати відповідь GPT');
    }
  }
}
