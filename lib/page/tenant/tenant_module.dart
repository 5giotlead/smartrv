import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/error/notfound_page.dart';
import 'package:flutter_rv_pms/page/booking/checkout/checkout_page.dart';
import 'package:flutter_rv_pms/page/member/control/control_page.dart';
import 'package:flutter_rv_pms/page/member/control/control_store.dart';
import 'package:flutter_rv_pms/page/member/manage/manage_page.dart';
import 'package:flutter_rv_pms/page/member/order/order_page.dart';
import 'package:flutter_rv_pms/page/member/rent/rent_page.dart';
import 'package:flutter_rv_pms/page/tenant/manage/camp_page.dart';
import 'package:flutter_rv_pms/page/tenant/manage/type_page.dart';

class TenantModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/manage-camp',
          child: (context, args) => const ManageCampPage(),
        ),
        ChildRoute(
          '/manage-type',
          child: (context, args) => const ManageTypePage(),
        ),
      ];
}
