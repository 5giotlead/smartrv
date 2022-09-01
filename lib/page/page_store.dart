import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/shared/models/page_info.dart';
import 'package:flutter_triple/flutter_triple.dart';

class PageStore extends NotifierStore<Exception, int> {
  PageStore() : super(0);

  final pagesNotifier = RxNotifier<List<PageInfo>>([
    PageInfo(
      '首頁',
      '/home',
      <String>['首頁', 'RV管理', 'RV控制'],
      const Icon(Icons.search),
    ),
    PageInfo(
      'RV管理',
      '/member/manage',
      <String>['首頁', 'RV控制', '登出'],
      const Icon(Icons.car_repair),
    ),
    PageInfo(
      'RV控制',
      '/member/control',
      <String>['首頁', 'RV管理', '登出'],
      const Icon(Icons.control_camera),
    ),
  ]);

  final _pages = <PageInfo>[
    PageInfo(
      '首頁',
      '/home',
      <String>['首頁', 'RV管理', 'RV控制'],
      const Icon(Icons.search),
    ),
    PageInfo(
      'RV管理',
      '/member/manage',
      <String>['首頁', 'RV控制', '登出'],
      const Icon(Icons.car_repair),
    ),
    PageInfo(
      'RV控制',
      '/member/control',
      <String>['首頁', 'RV管理', '登出'],
      const Icon(Icons.control_camera),
    ),
    PageInfo(
      '上架',
      '/member/rent',
      <String>['首頁', 'RV控制', '登出'],
      const Icon(Icons.car_repair),
    ),
    PageInfo(
      '登入',
      '/auth/login',
      <String>['首頁', 'RV管理', 'RV控制'],
      const Icon(Icons.login),
    ),
    PageInfo(
      '登出',
      '/auth/logout',
      <String>['首頁', 'RV管理', 'RV控制'],
      const Icon(Icons.logout),
    ),
  ];

  void updateState(int index) {
    update(index);
  }

  void setList(List<String> pagesInfo) {
    final widgets = <PageInfo>[];
    for (final pageInfo in pagesInfo) {
      widgets.add(_pages.firstWhere((element) => element.name == pageInfo));
    }
    pagesNotifier.value = widgets;
  }
}
