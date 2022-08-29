import 'dart:async';

import 'package:flutter/material.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

String storedPasscode = '123456';

class PscScreen extends StatefulWidget {
  String psw;

  PscScreen(this.psw, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PscScreenState();
}

class _PscScreenState extends State<PscScreen> {
  final StreamController<bool> _verificationNotifier =
      StreamController<bool>.broadcast();

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    storedPasscode = widget.psw;
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('輸入密碼'),
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        // ),
        body: Center(
      child: PasscodeScreen(
        title: Text(
          '請輸入密碼',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
        circleUIConfig: CircleUIConfig(
            borderColor: Colors.blue, fillColor: Colors.blue, circleSize: 30),
        keyboardUIConfig:
            KeyboardUIConfig(digitBorderWidth: 2, primaryColor: Colors.blue),
        passwordEnteredCallback: _onPasscodeEntered,
        cancelButton: Icon(
          Icons.turn_left,
          color: Colors.blue,
        ),
        deleteButton: const Icon(Icons.arrow_back),
        shouldTriggerVerification: _verificationNotifier.stream,
        backgroundColor: Colors.black.withOpacity(0.8),
        cancelCallback: _onPasscodeCancelled,
        digits: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'],
        passwordDigits: 4,
        bottomWidget: _buildPasscodeRestoreButton(),
        isValidCallback: _validFunc,
        // passwordResetCallback: _resetAppPassword,
      ),
    ));
  }

  _validFunc() {
    print('Valid');
    Modular.to.navigate('/home');
  }

  _onPasscodeEntered(String enteredPasscode) {
    bool isValid = storedPasscode == enteredPasscode;
    _verificationNotifier.add(isValid);
  }

  _onPasscodeCancelled() {
    // Navigator.of(context).pop();
    Modular.to.navigate('/home');
  }

  @override
  void dispose() {
    _verificationNotifier.close();
    super.dispose();
  }

  Widget _buildPasscodeRestoreButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0, top: 20.0),
        child: TextButton(
          child: Text(
            "清除全部",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
          ),
          onPressed: _resetAppPassword,
          // splashColor: Colors.white.withOpacity(0.4),
          // highlightColor: Colors.white.withOpacity(0.2),
          // ),
        ),
      ),
    );
  }

  _resetAppPassword() {
    print('reset');
  }
}
