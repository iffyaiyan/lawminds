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
      final response = await http.post(Uri.parse(url), body: jsonEncode(data), headers: header);

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
    } catch (_) {
      rethrow;
    }
  }

  Future<void> chatWithStream(String message, String sessionId, Function(String) onDataReceived) async {
    final url = '${dotenv.env['API_URL'] ?? ''}/chat/stream';
    final Map<String, dynamic> data = {'session_id': sessionId, 'message': message};
    final client = http.Client();

    try {
      final request = http.Request('POST', Uri.parse(url));
      request.body = jsonEncode(data);
      request.headers['Content-Type'] = 'application/json';
      final response = await client.send(request);

      if (response.statusCode != 200) {
        log('onError: $response');
        throw 'An error occurred';
      }

      await for (var chunk in response.stream.transform(utf8.decoder)) {
        onDataReceived(chunk);
      }
    } catch (_) {
      rethrow;
    } finally {
      client.close();
    }
  }
}