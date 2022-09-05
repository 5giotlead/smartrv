import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/l10n/l10n.dart';
import 'package:uni_links/uni_links.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<StatefulWidget> createState() => AppState();
}

class AppState extends State<AppWidget> {
  late StreamSubscription<dynamic> _sub;

  Future<void> initUniLinks() async {
    try {
      final initialUri = await getInitialUri();
    } on FormatException {
      print('error');
    }
  }

  Future<void> uniLinksChanged() async {
    _sub = uriLinkStream.listen(
      (Uri? uri) {
        Modular.to.navigate(uri!.path);
      },
      onError: (err) {},
    );
  }

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && !Platform.isWindows) {
      initUniLinks();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!kIsWeb && !Platform.isWindows) {
      uniLinksChanged();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (!kIsWeb && !Platform.isWindows) {
      _sub.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/home');
    return MaterialApp.router(
      title: 'Smart RV',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    ); //added by extension
  }
}
