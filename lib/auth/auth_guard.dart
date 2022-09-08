import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth/login');

  final _authStore = Modular.get<AuthStore>();

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    if (!path.startsWith('/auth')) {
      if (Modular.to.navigateHistory.isNotEmpty) {
        _authStore.pastPage = Modular.to.navigateHistory.last.uri.path;
      } else {
        _authStore.pastPage = '/home';
      }
      _authStore.forwardPage = path;
    }
    return _authStore.checkAuth();
  }
}

class AccessGuard extends RouteGuard {
  AccessGuard() : super(redirectTo: '/home');

  final _tbClient = Modular.get<ThingsboardClient>();

  @override
  Future<bool> canActivate(String path, ModularRoute route) {
    final user = _tbClient.getAuthUser();
    return Future.value(user?.authority == Authority.TENANT_ADMIN);
  }
}
