import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_guard.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/page/booking/booking_page.dart';
import 'package:flutter_rv_pms/page/home/home_page.dart';
import 'package:flutter_rv_pms/page/member/member_module.dart';
import 'package:flutter_rv_pms/page/page_store.dart';
import 'package:flutter_rv_pms/page/toggle/toggle_page.dart';
import 'package:flutter_rv_pms/widgets/bottom_nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class PageModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => PageStore()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const EntryPage(),
          children: [
            ChildRoute(
              '/home',
              child: (context, args) => const HomePage(),
            ),
            ChildRoute(
              '/toggle/:rvId',
              child: (context, args) => TogglePage(
                rvId: args.params['rvId'],
              ),
            ),
            ChildRoute(
              '/booking/:rvId',
              child: (context, args) => BookingPage(
                rvId: args.params['rvId'],
              ),
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

class EntryPage extends StatefulWidget {
  const EntryPage({super.key});

  @override
  State<StatefulWidget> createState() => _EntryState();
}

class _EntryState extends State<EntryPage> {
  final _authStore = Modular.get<AuthStore>();

  @override
  void initState() {
    super.initState();
    Modular.get<AuthStore>().checkAuth();
    removeUriParams();
  }

  Future<void> removeUriParams() async {
    final token = Modular.args.queryParams['accessToken'];
    final refreshToken = Modular.args.queryParams['refreshToken'];
    if (token != null && refreshToken != null) {
      if (kIsWeb) {
        await _authStore.setOauthAccess(token, refreshToken);
        Modular.to.navigate('/home');
        // } else if (Platform.isAndroid) {
      } else {
        if (!await launchUrl(
          Uri.parse(
            'smartrv://rv.5giotlead.com/?accessToken=$token&?refreshToken=$refreshToken',
          ),
          webOnlyWindowName: '_self',
        )) {
          throw Exception();
        }
      }
    } else {
      if (kIsWeb && _authStore.forwardPage != '') {
        Modular.to.navigate(_authStore.forwardPage);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
// debugPaintSizeEnabled = true;
    return Scaffold(
      body: Column(
        children: const [
          Expanded(child: RouterOutlet()),
          BottomNavBar(),
        ],
      ),
    );
  }
}
