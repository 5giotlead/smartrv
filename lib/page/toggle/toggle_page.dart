import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class TogglePage extends StatefulWidget {
  TogglePage({super.key, required deviceId});

  @override
  State<StatefulWidget> createState() => _PscScreenState();
}

class _PscScreenState extends State<TogglePage> {
  final _tbClient = Modular.get<ThingsboardClient>();
  final _dio = Modular.get<Dio>();
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  Future<void> _toggleSwitch(String passcode) async {
    bool isValid = false;
    final rvId = Modular.args.params['rvId'] as String;
    try {
      final res = await _dio.get(
        '/smartrv/locker/$rvId/$passcode',
      );
      if (res.data['message'] == null) {
        isValid = true;
      }
    } catch (e) {
      print(e);
    } finally {
      _verificationNotifier.add(isValid);
    }
  }

  void _navToHome() {
    Modular.to.navigate('/home');
  }

  Future<void> _onPasscodeEntered(String enteredCode) async {
    if (enteredCode.length == 4) {
      await _toggleSwitch(enteredCode);
    }
  }

  void _onPasscodeCancelled() {
    _navToHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: PasscodeScreen(
        title: const Text(
          '請輸入密碼',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        circleUIConfig: const CircleUIConfig(
            borderColor: Colors.blue, fillColor: Colors.blue, circleSize: 30),
        keyboardUIConfig: const KeyboardUIConfig(
            digitBorderWidth: 2, primaryColor: Colors.blue),
        passwordEnteredCallback: _onPasscodeEntered,
        isValidCallback: _navToHome,
        cancelButton: const Icon(
          Icons.turn_left,
          color: Colors.blue,
        ),
        deleteButton: const Icon(Icons.arrow_back),
        shouldTriggerVerification: _verificationNotifier.stream,
        backgroundColor: Colors.black.withOpacity(0.8),
        cancelCallback: _onPasscodeCancelled,
        // digits: const ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
        passwordDigits: 4,
      ),
    ));
  }
}
