import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ChatService {
  Future<String> getAnswer(String q) async {
    try {
      final response = await http.get(Uri.parse('${dotenv.env['API_URL'] ?? ''}?question=$q'));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return json['answer'] ?? json['detail'] ?? 'An error occurred';
      } else {
        log('Catch Response Error: ${response.body}');
        throw 'An error occurred';
      }
    } catch (e) {
      log('Catch Error: $e');
      throw 'An error occurred';
    }
  }
}