import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatService {
  Future<String> chat(String message, String sessionId) async {
    try {
      final url = '${dotenv.env['API_URL'] ?? ''}/chat';
      final Map<String, dynamic> data = {'session_id': sessionId, 'message': message};
      final Map<String, String> header = {
        'Content-Type': 'application/json',
      };
      final response = await http.post(Uri.parse(url), body: json.encode(data), headers: header);

      log('onRequest: $url\nbody: $data');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json.isEmpty) return 'No response received from bot';
        return json;
      } else {
        final json = jsonDecode(response.body);

        log('onError: ${response.body}');
        throw json['detail'] ?? 'An error occurred';
      }
    } catch (e) {
      throw '$e';
    }
  }
}