import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/l10n/l10n.dart';
import 'package:flutter_rv_pms/page/page_store.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar();

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<BottomNavBar> {
  final _pageStore = Modular.get<PageStore>();
  int index = 0;

  @override
  void initState() {
    _pageStore.observer(onState: (state) => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: context.l10n.bottomNavBarTab1,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: context.l10n.bottomNavBarTab2,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.login),
          label: context.l10n.bottomNavBarTab3,
        ),
      ],
      currentIndex: _pageStore.state, // now index
      fixedColor: Colors.amber, // selecter page
      onTap: _onItemClick, // press event
    );
  }

  Future<void> _onItemClick(int index) async {
    _pageStore.setIndex(index);
    if (index == 0) {
      Modular.to.navigate('/home');
    } else if (index == 1) {
      await launchUrl(
        Uri.parse('smartrv://rv.5giotlead.com/member/control'),
        webOnlyWindowName: '_self',
      );
    } else {
      Modular.to.navigate('/member/rent');
    }
  }
}
