import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/l10n/l10n.dart';
import 'package:flutter_rv_pms/page/page_store.dart';
import 'package:flutter_rv_pms/shared/models/page_info.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<BottomNavBar> {
  final _pageStore = Modular.get<PageStore>();
  int currentIndex = 0;

  void initListener() {
    _pageStore.pagesNotifier.addListener(rebuildPageList);
  }

  void disposeListener() {
    _pageStore.pagesNotifier.removeListener(rebuildPageList);
  }

  void rebuildPageList() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initListener();
  }

  @override
  void dispose() {
    super.dispose();
    disposeListener();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: NavigationListener(
        builder: (context, child) {
          return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              for (int i = 0; i < _pageStore.pagesNotifier.value.length; i++)
                BottomNavigationBarItem(
                  icon: _pageStore.pagesNotifier.value[i].icon,
                  label: _pageStore.pagesNotifier.value[i].name,
                  // label: context.l10n.bottomNavBarTab1,
                ),
            ],
            currentIndex: _pageStore.state, // now index
            // fixedColor: Colors.amber, // selecter page
            onTap: _onItemClick, // press event
          );
        },
      ),
    );
  }

  Future<void> _onItemClick(int index) async {
    Modular.to.navigate(_pageStore.pagesNotifier.value[index].route);
    _pageStore
      ..setList(_pageStore.pagesNotifier.value[index].pages)
      ..updateState(index);
  }
}
