import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth/login');

  final _authStore = Modular.get<AuthStore>();

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    _authStore.pastPage = path;
    return Modular.get<AuthStore>().checkAuth();
  }
}
