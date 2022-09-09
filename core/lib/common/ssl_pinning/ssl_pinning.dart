import 'package:core/common/ssl_pinning/shared.dart';
import 'package:http/http.dart' as http;

class SSLpinning {
  static http.Client? _client;
  static http.Client get client => _client ?? http.Client();

  static Future<http.Client> get _instance async =>
      _client ??= await Shared.initializeClient();

  static Future<void> init() async {
    _client = await _instance;
  }
}
