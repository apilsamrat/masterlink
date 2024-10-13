import 'dart:convert';
import 'package:http/http.dart' as http;

class Network {
  Future<http.Response> shortURL(
      {required String longURL, required bool customURL, String? alias}) async {
    final url = Uri.parse("https://www.ishortn.ink/api/v1/links");

    final headers = {
      "x-api-key": "eBYAzYFFMdnyDA8JOOui8tIm4DO5Y",
      "Content-Type": "application/json",
      "Accept": "application/json",
    };
    final body =
        customURL ? {"url": longURL, "alias": alias} : {"url": longURL};
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
