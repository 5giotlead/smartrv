import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';

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
    return Modular.get<AuthStore>().checkAuth();
  }
}
