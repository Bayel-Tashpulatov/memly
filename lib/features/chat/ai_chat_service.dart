import 'dart:convert';
import 'package:http/http.dart' as http;

const openAiApiKey = '';
const openAiEndpoint = 'https://api.openai.com/v1/chat/completions';

Future<String> sendMessageToAI(String message) async {
  final response = await http.post(
    Uri.parse(openAiEndpoint),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $openAiApiKey',
    },
    body: jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'user', 'content': message},
      ],
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final reply = data['choices'][0]['message']['content'];
    return reply.trim();
  }else{
    print('Ошибка:  ${response.body}');
    return 'Ошибка. Попробуйте еще раз.';
  }
}
