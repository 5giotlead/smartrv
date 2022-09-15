import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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

  Future<void> setTokenFromTBClient() async {
    await _storage.write(
      key: 'token',
      value: _tbClient.getJwtToken(),
    );
    await _storage.write(
      key: 'refreshToken',
      value: _tbClient.getRefreshToken(),
    );
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'token');
    await _storage.delete(key: 'refreshToken');
  }

  Future<bool> checkAuth() async {
    if (!_tbClient.isAuthenticated()) {
      final token = await _storage.read(key: 'token');
      final refreshToken = await _storage.read(key: 'refreshToken');
      if (token != null && refreshToken != null) {
        await _tbClient.setUserFromJwtToken(token, refreshToken, true);
        if (!_tbClient.isJwtTokenValid()) {
          await _tbClient.refreshJwtToken(
            refreshToken: _tbClient.getRefreshToken(),
            notify: true,
          );
          if (_tbClient.getJwtToken() != null &&
              _tbClient.getRefreshToken() != null) {
            await setTokenFromTBClient();
          } else {
            await clearToken();
          }
        }
      }
    }
    update(_tbClient.isAuthenticated());
    authNotifier.value = state;
    // await checkAccess();
    return state;
  }
}
