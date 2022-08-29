import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/l10n/l10n.dart';
import 'package:flutter_rv_pms/page/page_store.dart';
import 'package:flutter_rv_pms/shared/models/page_info.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar();

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<BottomNavBar> {
  final _pageStore = Modular.get<PageStore>();
  List<PageInfo> pages = [
    PageInfo(
      '首頁',
      '/home',
      <String>['首頁', '上架', 'RV控制'],
      const Icon(Icons.home),
    ),
    PageInfo(
      '上架',
      '/member/rent',
      <String>['首頁', 'RV控制', '登出'],
      const Icon(Icons.car_repair),
    ),
    PageInfo(
      'RV控制',
      '/member/control',
      <String>['首頁', '上架', '登出'],
      const Icon(Icons.control_camera),
    ),
  ];
  int currentIndex = 0;

  @override
  bool mounted = false;

  @override
  void initState() {
    mounted = true;
    _pageStore.observer(
      onState: (state) => {
        if (mounted)
          setState(() {
            pages = state;
          }),
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mounted = false;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        for (int i = 0; i < pages.length; i++)
          BottomNavigationBarItem(
            icon: pages[i].icon,
            label: pages[i].name,
            // label: context.l10n.bottomNavBarTab1,
          ),
      ],
      currentIndex: currentIndex, // now index
      // fixedColor: Colors.amber, // selecter page
      onTap: _onItemClick, // press event
    );
  }

  Future<void> _onItemClick(int index) async {
    // if (index == 0) {
    Modular.to.navigate(pages[index].route);
    _pageStore.setList(pages[index].pages);
    currentIndex = index;
    // } else if (index == 1) {
    //   await launchUrl(
    //     Uri.parse('smartrv://rv.5giotlead.com/member/control'),
    //     webOnlyWindowName: '_self',
    //   );
    // } else {
    //   Modular.to.navigate('/member/rent');
    // }
  }
}
