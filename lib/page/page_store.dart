import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/shared/models/page_info.dart';
import 'package:flutter_triple/flutter_triple.dart';

class PageStore extends NotifierStore<Exception, List<PageInfo>> {
  PageStore()
      : super([
          PageInfo('home', '/home', <String>['home', 'booking', 'login'],
              const Icon(Icons.search)),
          PageInfo(
            'booking',
            '/booking',
            <String>['home', 'rent', 'login'],
            const Icon(Icons.search),
          ),
          PageInfo('login', '/auth/login', <String>['home', 'booking', 'login'],
              const Icon(Icons.login)),
        ]);

  List<PageInfo> pages = <PageInfo>[
    PageInfo(
      'home',
      '/home',
      <String>['home', 'booking', 'login'],
      const Icon(Icons.search),
    ),
    PageInfo(
      'rent',
      '/member/rent',
      <String>['home', 'control', 'logout'],
      const Icon(Icons.car_repair),
    ),
    PageInfo(
      'control',
      '/member/control',
      <String>['home', 'rent', 'logout'],
      const Icon(Icons.search),
    ),
    PageInfo(
      'booking',
      '/booking',
      <String>['home', 'rent', 'login'],
      const Icon(Icons.search),
    ),
    PageInfo(
      'login',
      '/auth/login',
      <String>['home', 'booking', 'login'],
      const Icon(Icons.login),
    ),
    PageInfo(
      'logout',
      '/auth/logout',
      <String>['home', 'booking', 'login'],
      const Icon(Icons.logout),
    ),
  ];

  void setList(List<String> pagesInfo) {
    final widgets = <PageInfo>[];
    for (final pageInfo in pagesInfo) {
      widgets.add(pages.firstWhere((element) => element.name == pageInfo));
    }
    update(widgets);
  }
}
