import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/error/notfound_page.dart';
import 'package:flutter_rv_pms/page/booking/widgets/check_page.dart';
import 'package:flutter_rv_pms/page/member/control/control_page.dart';
import 'package:flutter_rv_pms/page/member/control/control_store.dart';
import 'package:flutter_rv_pms/page/member/manage/manage_page.dart';
import 'package:flutter_rv_pms/page/member/order/order_page.dart';
import 'package:flutter_rv_pms/page/member/rent/rent_page.dart';

class MemberModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.lazySingleton((i) => ControlStore()),

  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/rent', child: (context, args) => RentPage()),
        ChildRoute('/control', child: (context, args) => const ControlPage()),
        ChildRoute('/shopping', child: (context, args) => const OrderPage()),
        ChildRoute('/check', child: (context, args) => const CheckPage()),
        ChildRoute(
          '/manage',
          child: (context, args) => const ManagePage(),
        ),
        WildcardRoute(child: (context, args) => NotFoundPage()),
      ];
}
