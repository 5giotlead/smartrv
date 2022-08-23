// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_rv_pms/app/app_widget.dart';
import 'package:flutter_rv_pms/page/page_module.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders EntryPage', (tester) async {
      await tester.pumpWidget(const AppWidget());
      expect(find.byType(EntryPage), findsOneWidget);
    });
  });
}
