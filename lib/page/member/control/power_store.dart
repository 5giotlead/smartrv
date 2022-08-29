import 'package:flutter_triple/flutter_triple.dart';

class PowerStore extends NotifierStore<Exception, String> {
  PowerStore() : super('0');

  void setPower(String power) {
    update(power);
  }
}
