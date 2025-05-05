import 'dart:convert';
import 'package:http/http.dart' as http;

const openAiApiKey = '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';
const openAiEndpoint = 'https://openrouter.ai/api/v1/chat/completions';

Future<String> sendMessageToAI(String message) async {
  try {
    final response = await http.post(
      Uri.parse(openAiEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $openAiApiKey',
        'X-Title': 'Memly',
      },
      body: jsonEncode({
        'model': 'google/gemma-2-9b-it:free',
        'messages': [
          {'role': 'user', 'content': message},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      final reply = data['choices']?.isEmpty ?? true
          ? 'Ответ не получен.'
          : data['choices'][0]['message']['content'];
      return reply.trim();
    } else {
      print('Ошибка: ${response.statusCode} ${utf8.decode(response.bodyBytes)}');
      return 'Ошибка. Попробуйте еще раз.';
    }
  } catch (e) {
    print('Произошла ошибка: $e');
    return 'Ошибка. Попробуйте еще раз.';
  }
}
