import 'dart:io';

class HttpOverrideService extends HttpOverrides {
  final String proxy;

  HttpOverrideService.withProxy(this.proxy);

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..findProxy = (uri) {
        return 'PROXY $proxy:8888';
      }
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
