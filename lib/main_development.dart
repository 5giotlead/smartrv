import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/app/app_module.dart';
import 'package:flutter_rv_pms/app/app_widget.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}
