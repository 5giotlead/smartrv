import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/shared/models/page_info.dart';
import 'package:flutter_rv_pms/shared/models/page_info_dynamic.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

final _pages = <PageInfoDynamic>[
  PageInfoDynamic(
    '首頁',
    '/home',
    <String>['首頁', 'RV上架', 'RV管理', 'RV控制'],
    const Icon(Icons.search),
  ),
  PageInfoDynamic(
    'RV上架',
    '/member/rent',
    <String>['首頁', 'RV上架', 'RV管理', 'RV控制'],
    const Icon(Icons.car_repair),
  ),
  PageInfoDynamic(
    'RV管理',
    '/member/manage',
    <String>['首頁', 'RV上架', 'RV管理', 'RV控制'],
    const Icon(Icons.car_repair),
  ),
  PageInfoDynamic(
    'RV控制',
    '/member/control',
    <String>['首頁', 'RV上架', 'RV管理', 'RV控制'],
    const Icon(Icons.control_camera),
  ),
  PageInfoDynamic(
    '登入',
    '/auth/login',
    <String>['首頁', 'RV上架', 'RV管理', 'RV控制'],
    const Icon(Icons.login),
  ),
  PageInfoDynamic(
    '登出',
    '/auth/logout',
    <String>['首頁', '登入'],
    const Icon(Icons.logout),
  ),
];

class PageStore extends NotifierStore<Exception, int> {
  PageStore() : super(0);

  final pagesNotifier = RxNotifier<List<PageInfoDynamic>>(
      [_pages[0], _pages[1], _pages[2], _pages[3]]);

  void updateState(int index) {
    update(index);
  }

  void setList(List<String> pagesInfo) {
    final widgets = <PageInfoDynamic>[];
    for (final pageInfo in pagesInfo) {
      widgets.add(_pages.firstWhere((element) => element.name == pageInfo));
    }
    pagesNotifier.value = widgets;
  }

  void setListByAccess(AuthUser user) {
    if (user.authority == Authority.TENANT_ADMIN) {
    } else if (user.authority == Authority.CUSTOMER_USER) {
    } else {
      pagesNotifier.value = [
        _pages.firstWhere((element) => element.name == '首頁'),
        _pages.firstWhere((element) => element.name == '登入')
      ];
    }
  }
}
