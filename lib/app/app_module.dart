import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_module.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/error/notfound_page.dart';
import 'package:flutter_rv_pms/page/page_module.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class AppModule extends Module {
  final baseURL = 'https://rv.5giotlead.com';

  // final baseURL = 'https://rv.5giotlead.com:8081';

  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => AuthStore()),
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
        WildcardRoute(child: (context, args) => NotFoundPage()),
      ];
}
