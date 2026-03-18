import 'package:dio/dio.dart';

class AIService {
  // 🔑 Groq API Key
  static const String _apiKey = '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';
  final Dio _dio = Dio();

  AIService() {
    _dio.options.baseUrl = 'https://api.groq.com/openai/v1';
    _dio.options.headers = {
      'Authorization': 'Bearer $_apiKey',
      'Content-Type': 'application/json',
    };
  }

  Future<String> getResponse(String message) async {
    try {
      if (_apiKey.isEmpty) {
        return 'Please enter your API Key to start chatting!';
      }

      final response = await _dio.post(
        '/chat/completions',
        data: {
          // Using the latest stable model: Llama 3.3 70B
          'model': 'llama-3.3-70b-versatile',
          'messages': [
            {
              'role': 'system',
              'content': 'You are a helpful, friendly, and highly intelligent AI assistant. '
                  'Respond naturally like a human in the same language as the user. '
                  'Provide accurate and high-quality answers. Keep the conversation engaging.'
            },
            {'role': 'user', 'content': message}
          ],
          'temperature': 0.7,
        },
      );

      return response.data['choices'][0]['message']['content'] ?? 'No response received.';
    } catch (e) {
      if (e is DioException) {
        // Extracting specific error from Groq response if available
        final errorMessage = e.response?.data?['error']?['message'] ?? e.message;
        return 'Groq Error: $errorMessage';
      }
      return 'Error: $e';
    }
  }
}
