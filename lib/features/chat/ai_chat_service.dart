import 'dart:convert';
import 'package:http/http.dart' as http;

const openAiApiKey =
    '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';
const openAiEndpoint = 'https://openrouter.ai/api/v1/chat/completions';

Future<String> sendMessageToAI(String message) async {
  final response = await http.post(
    Uri.parse(openAiEndpoint),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openAiApiKey',
      'X-Title': 'Memly',
    },
    body: jsonEncode({
      'model': 'openai/gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': message},
      ],
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final reply = data['choices'][0]['message']['content'];
    return reply.trim();
  } else {
    print('Ошибка:  ${response.body}');
    return 'Ошибка. Попробуйте еще раз.';
  }
}
