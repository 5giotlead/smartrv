import 'package:flutter_triple/flutter_triple.dart';

class PageStore extends NotifierStore<Exception, int> {
  PageStore() : super(0);

  void setIndex(int i) {
    update(i);
  }
}
