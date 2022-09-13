import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_module.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/error/notfound_page.dart';
import 'package:flutter_rv_pms/page/home/widgets/qr_scan.dart';
import 'package:flutter_rv_pms/page/page_module.dart';
import 'package:flutter_rv_pms/page/page_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class AppModule extends Module {
  final baseURL = '';

  // final baseURI = 'http://localhost:8080';
  // final baseURL = 'https://rv.5giotlead.com:8080';

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AuthStore()),
        Bind.lazySingleton((i) => PageStore()),
        Bind.lazySingleton(
          (i) => ThingsboardClient(baseURL),
        ),
        Bind.lazySingleton((i) => Dio()..options.baseUrl = baseURL),
        Bind.lazySingleton((i) => const FlutterSecureStorage()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: PageModule(),
        ),
        ModuleRoute(
          '/auth',
          module: AuthModule(),
        ),
        ChildRoute(
          '/qr-scan',
          child: (context, args) => QRScan(),
        ),
        WildcardRoute(child: (context, args) => NotFoundPage()),
      ];
}
