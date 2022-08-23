import 'package:flutter_triple/flutter_triple.dart';

class ControlStore extends NotifierStore<Exception, bool> {
  ControlStore() : super(false);

  void setSwitchStatus(bool status) {
    update(status);
  }
}
