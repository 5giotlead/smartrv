import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/shared/models/page_info.dart';
import 'package:flutter_triple/flutter_triple.dart';

class ControlStore extends NotifierStore<Exception, bool> {
  ControlStore() : super(false);

  final switchNotifier = RxNotifier<bool>(false);

  final powerNotifier = RxNotifier<String>('0');

  void setSwitchStatus(dynamic status) {
    if (status is String) {
      switchNotifier.value = status == 'ON';
    } else if (status is bool) {
      switchNotifier.value = status;
    }
  }

  void setPowerStatus(String status) {
    powerNotifier.value = status;
  }
}
