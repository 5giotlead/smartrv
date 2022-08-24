import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class TogglePage extends StatelessWidget {
  TogglePage({super.key, required deviceId});

  final tbClient = Modular.get<ThingsboardClient>();

  Future<void> toggleSwitch() async {
    final deviceId = Modular.args.params['deviceId'] as String;
    if (deviceId != '') {
      final data = jsonEncode({
        'method': 'Switch.Toggle',
        'params': {'id': 0}
      });
      try {
        await tbClient.post<String>(
          '/api/rpc/twoway/$deviceId',
          data: data,
        );
      } catch (e) {
        print(e);
      } finally {
        Modular.to.navigate('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    toggleSwitch();
    return const SizedBox();
  }
}
