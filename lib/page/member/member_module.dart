import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/error/notfound_page.dart';
import 'package:flutter_rv_pms/page/booking/widgets/check_page.dart';
import 'package:flutter_rv_pms/page/member/control/control_page.dart';
import 'package:flutter_rv_pms/page/member/menage/manage_page.dart';
import 'package:flutter_rv_pms/page/member/rent/rent_page.dart';
import 'package:flutter_rv_pms/shopping/shopping.dart';

class MemberModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/control',
          child: (context, args) => ControlPage(),
        ),
        ChildRoute('/rent', child: (context, args) => RentPage()),
        ChildRoute('/shopping', child: (context, args) => const ShoppingPage()),
        ChildRoute('/check', child: (context, args) => const CheckPage()),
        ChildRoute(
          '/manage',
          child: (context, args) => const ManagePage(),
        ),
        WildcardRoute(child: (context, args) => NotFoundPage()),
      ];
}
