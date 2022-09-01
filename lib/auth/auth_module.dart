import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/login/login_page.dart';
import 'package:flutter_rv_pms/auth/logout/logout_page.dart';
import 'package:flutter_triple/flutter_triple.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/login',
          child: (context, args) => const LoginPage(),
        ),
        ChildRoute(
          '/logout',
          child: (context, args) => LogoutPage(),
        ),
      ];
}
