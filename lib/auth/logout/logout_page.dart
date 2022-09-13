import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/auth/login/cubit/login_cubit.dart';
import 'package:flutter_rv_pms/l10n/l10n.dart';
import 'package:flutter_rv_pms/page/page_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class LogoutPage extends StatelessWidget {
  LogoutPage({super.key});

  final _tbClient = Modular.get<ThingsboardClient>();
  final _storage = Modular.get<FlutterSecureStorage>();
  final _authStore = Modular.get<AuthStore>();
  final _pageStore = Modular.get<PageStore>();

  Future<void> _logout() async {
    try {
      await _tbClient.logout();
      // await _storage.deleteAll();
      await _storage.delete(key: 'token');
      await _storage.delete(key: 'refreshToken');
      _pageStore.setListByAccess(await _authStore.getCurrentUser());
      _authStore.forwardPage = '';
    } catch (e) {
      print(e);
    } finally {
      Modular.to.navigate('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    _logout();
    return BlocProvider(
      create: (_) => LogoutCubit(),
      child: const LogoutView(),
    );
  }
}

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.logoutAppBarTitle)),
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Text(l10n.loggingOutText),
      ),
    );
  }
}
