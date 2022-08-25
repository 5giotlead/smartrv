import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_guard.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/page/home/home_page.dart';
import 'package:flutter_rv_pms/page/member/booking/booking_page.dart';
import 'package:flutter_rv_pms/page/member/control/control_store.dart';
import 'package:flutter_rv_pms/page/member/member_module.dart';
import 'package:flutter_rv_pms/widgets/bottom_nav_bar.dart';
import 'package:flutter_rv_pms/widgets/passcode.dart';
import 'package:url_launcher/url_launcher.dart';

class PageModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ControlStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const EntryPage(),
          children: [
            ChildRoute(
              '/home',
              child: (context, args) => HomePage(),
            ),
            ChildRoute(
              '/passcode',
              child: (context, args) => PscScreen('456789'),
            ),
            ChildRoute(
              '/booking',
              child: (context, args) => BookingPage({args.data}),
            ),
            ModuleRoute(
              '/member',
              module: MemberModule(),
              guards: [AuthGuard()],
            ),
          ],
        ),
      ];
}

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  // void removeUriParams() {
  void removeUriParams() async {
    final token = Modular.args.queryParams['accessToken'];
    final refreshToken = Modular.args.queryParams['refreshToken'];
    if (token != null && refreshToken != null) {
      if (kIsWeb) {
        await Modular.get<AuthStore>().setOauthAccess(token, refreshToken);
        // } else if (Platform.isAndroid) {
      } else {
        if (!await launchUrl(
          Uri.parse(
            'smartrv://rv.5giotlead.com/?accessToken=$token&?refreshToken=$refreshToken',
          ),
          webOnlyWindowName: '_self',
        )) {
          throw 'Could not launch';
        }
      }
    }
    Modular.to.navigate('/home');
  }

  @override
  Widget build(BuildContext context) {
    removeUriParams();
    // debugPaintSizeEnabled = true;
    return Scaffold(
        bottomNavigationBar: BottomNavBar(),
        body: Container(
          child: Row(
            children: const [
              // Container(width: 2, color: Colors.black45),
              Expanded(child: RouterOutlet()),
            ],
          ),
        ));
  }
}
