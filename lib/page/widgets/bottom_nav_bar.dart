import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/page/page_store.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<StatefulWidget> createState() => _NavBarState();
}

class _NavBarState extends State<BottomNavBar> {
  final _pageStore = Modular.get<PageStore>();

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
    return NavigationListener(
      builder: (context, child) {
        return Row(
          children: [
            for (int i = 0; i < _pageStore.pagesNotifier.value.length; i++)
              Expanded(
                child: ListTile(
                  title: Column(
                    children: [
                      _pageStore.pagesNotifier.value[i].icon,
                      Text(_pageStore.pagesNotifier.value[i].name)
                    ],
                  ),
                  onTap: () => {
                    if (_pageStore.pagesNotifier.value[i].route == '/qr-scan' ||
                        _pageStore.pagesNotifier.value[i].route ==
                            '/auth/login')
                      {
                        Modular.to
                            .pushNamed(_pageStore.pagesNotifier.value[i].route),
                      }
                    else
                      {
                        Modular.to
                            .navigate(_pageStore.pagesNotifier.value[i].route),
                      }
                  },
                  selected: Modular.to.path
                      .endsWith(_pageStore.pagesNotifier.value[i].route),
                ),
              ),
          ],
        );
      },
    );
  }
}
