import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class Shared {
  static Future<IOClient> initializeClient() async {
    final ByteData certificates =
        await rootBundle.load('certificates/certificates.pem');
    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext
        .setTrustedCertificatesBytes(certificates.buffer.asInt8List());
    HttpClient httpClient = HttpClient(context: securityContext);
    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return IOClient(httpClient);
  }
}
