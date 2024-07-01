import 'dart:convert';

import 'package:http/http.dart';
import 'package:ws_cars/infra/remote/http_service.dart';

import 'http_error.dart';

class HttpServiceImp implements HttpService {
  final Client client = Client();

  @override
  Future<Map<String, dynamic>?> get(String path,
      {Map<String, dynamic>? queryParameters}) async {
    return await request(
      url: path,
      method: "GET",
    );
  }

  @override
  Future post(String path, {Map<String, dynamic>? body}) async {
    return await request(url: path, method: "POST", body: body);
  }

  Future<Map<String, dynamic>?> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    try {
      final headers = {
        'content-type': 'application/json',
      };
      final jsonBody = body != null ? jsonEncode(body) : null;
      var response = Response('', 500);
      if (method == 'POST') {
        response =
            await client.post(Uri.parse(url), headers: headers, body: jsonBody);
      }
      if (method == 'GET') {
        response = await client.get(
          Uri.parse(url),
          headers: headers,
        );
      }
      return _handleResponse(response);
    } catch (_) {
      throw HttpError.unknown;
    }
  }

  Map<String, dynamic>? _handleResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
