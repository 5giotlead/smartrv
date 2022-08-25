import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/page/booking/widgets/check_page.dart';
import 'package:flutter_rv_pms/error/notfound_page.dart';
import 'package:flutter_rv_pms/shopping/shopping.dart';
import 'package:flutter_rv_pms/page/member/booking/booking_page.dart';
import 'package:flutter_rv_pms/page/member/control/control_page.dart';
import 'package:flutter_rv_pms/page/member/rent/rent_page.dart';
import 'package:flutter_rv_pms/page/member/toggle/toggle_page.dart';

class MemberModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/control',
          child: (context, args) => ControlPage(),
        ),
        ChildRoute('/rent', child: (context, args) => RentPage({args.data})),
        ChildRoute('/shopping', child: (context, args) => ShoppingPage()),
        ChildRoute('/check', child: (context, args) => CheckPage()),
        ChildRoute(
          '/booking',
          child: (context, args) => BookingPage(args.data),
        ),
        ChildRoute(
          '/toggle/:deviceId',
          child: (context, args) => TogglePage(
            deviceId: args.params['deviceId'],
          ),
        ),
        WildcardRoute(child: (context, args) => NotFoundPage()),
      ];
}
