import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar();

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

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
      currentIndex: _currentIndex, // now index
      fixedColor: Colors.amber, // selecter page
      onTap: _onItemClick, // press event
    );
  }

  void _onItemClick(int index) async {
    _currentIndex = index;
    if (index == 0) {
      setState(() {
        Modular.to.navigate('/home');
      });
    } else if (index == 1) {
      await launchUrl(
        Uri.parse('smartrv://rv.5giotlead.com/member/control'),
        webOnlyWindowName: '_self',
      );
      setState(() {});
    } else {
      setState(() {
        Modular.to.navigate('/auth/login');
      });
    }
  }
}
