import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/shared/models/page_info.dart';
import 'package:flutter_triple/flutter_triple.dart';

class PageStore extends NotifierStore<Exception, List<PageInfo>> {
  PageStore()
      : super([
          PageInfo(
            'home',
            '/home',
            <String>['home', 'booking', 'control'],
            const Icon(Icons.search),
          ),
          PageInfo(
            'booking',
            '/booking',
            <String>['home', 'rent', 'control'],
            const Icon(Icons.search),
          ),
          PageInfo(
            'login',
            '/auth/login',
            <String>['home', 'booking', 'control'],
            const Icon(Icons.login),
          ),
        ]);

  List<PageInfo> pages = <PageInfo>[
    PageInfo(
      '首頁',
      '/home',
      <String>['首頁', '訂房', 'RV控制'],
      const Icon(Icons.search),
    ),
    PageInfo(
      '上架',
      '/member/rent',
      <String>['首頁', '訂房', 'RV控制'],
      const Icon(Icons.car_repair),
    ),
    PageInfo(
      'RV控制',
      '/member/control',
      <String>['首頁', '訂房', '上架'],
      const Icon(Icons.control_camera),
    ),
    PageInfo(
      '訂房',
      '/booking',
      <String>['首頁', '上架', 'RV控制'],
      const Icon(Icons.search),
    ),
    PageInfo(
      'login',
      '/auth/login',
      <String>['首頁', '訂房', 'RV控制'],
      const Icon(Icons.login),
    ),
    PageInfo(
      'logout',
      '/auth/logout',
      <String>['home', 'booking', 'control'],
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
