import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class AuthStore extends NotifierStore<Exception, bool> {
  AuthStore() : super(false);

  final authNotifier = RxNotifier<bool>(false);

  final _tbClient = Modular.get<ThingsboardClient>();
  final _dio = Modular.get<Dio>();
  final _storage = Modular.get<FlutterSecureStorage>();
  String pastPage = '';
  String forwardPage = '';

  Future<void> checkAccess() async {
    if (state) {
      // await _dio.get('/smartrv/access/${_tbClient.getAuthUser()?.userId}');
    }
  }

  Future<AuthUser?> getCurrentUser() async {
    await checkAuth();
    return _tbClient.getAuthUser();
  }

  Future<void> setOAuthAccess(String token, String refreshToken) async {
    await _tbClient.setUserFromJwtToken(token, refreshToken, true);
    await _storage.write(key: 'token', value: token);
    await _storage.write(key: 'refreshToken', value: refreshToken);
    await getCurrentUser();
  }

  Future<bool> checkAuth() async {
    final token = await _storage.read(key: 'token');
    final refreshToken = await _storage.read(key: 'refreshToken');
    if (!(_tbClient.isAuthenticated() ||
        token == null ||
        refreshToken == null)) {
      await _tbClient.setUserFromJwtToken(token, refreshToken, true);
    }
    update(_tbClient.isAuthenticated() && _tbClient.isJwtTokenValid());
    authNotifier.value = state;
    // await checkAccess();
    return state;
  }
}
