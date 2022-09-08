import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/shared/models/page_info.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

final _pages = <PageInfo>[
  PageInfo(
    '首頁',
    '/home',
    const Icon(Icons.search),
  ),
  PageInfo(
    'QR掃描',
    '/qr-scan',
    const Icon(Icons.qr_code),
  ),
  PageInfo(
    '營區管理',
    '/tenant/manage-camp',
    const Icon(Icons.search),
  ),
  PageInfo(
    '車款管理',
    '/tenant/manage-type',
    const Icon(Icons.search),
  ),
  PageInfo(
    'RV上架',
    '/member/rent',
    const Icon(Icons.car_repair),
  ),
  PageInfo(
    'RV管理',
    '/member/manage',
    const Icon(Icons.car_repair),
  ),
  PageInfo(
    'RV控制',
    '/member/control',
    const Icon(Icons.control_camera),
  ),
  PageInfo(
    '登入',
    '/auth/login',
    const Icon(Icons.login),
  ),
  PageInfo(
    '登出',
    '/auth/logout',
    const Icon(Icons.logout),
  ),
];

class PageStore extends NotifierStore<Exception, int> {
  PageStore() : super(0);

  final pagesNotifier = RxNotifier<List<PageInfo>>([
    _pages.firstWhere((element) => element.name == '首頁'),
    _pages.firstWhere((element) => element.name == 'QR掃描'),
    _pages.firstWhere((element) => element.name == '登入')
  ]);

  void updateState(int index) {
    update(index);
  }

  void setListByAccess(AuthUser? user) {
    if (user != null) {
      if (user.authority == Authority.TENANT_ADMIN) {
        pagesNotifier.value = [
          _pages.firstWhere((element) => element.name == '首頁'),
          _pages.firstWhere((element) => element.name == 'RV上架'),
          _pages.firstWhere((element) => element.name == 'RV管理'),
          _pages.firstWhere((element) => element.name == 'RV控制'),
          // _pages.firstWhere((element) => element.name == '首頁'),
          // _pages.firstWhere((element) => element.name == '營區管理'),
          // _pages.firstWhere((element) => element.name == '車款管理'),
        ];
      } else if (user.authority == Authority.CUSTOMER_USER) {
        pagesNotifier.value = [
          _pages.firstWhere((element) => element.name == '首頁'),
          _pages.firstWhere((element) => element.name == 'RV上架'),
          _pages.firstWhere((element) => element.name == 'RV管理'),
          _pages.firstWhere((element) => element.name == 'RV控制'),
        ];
      } else {
        pagesNotifier.value = [
          _pages.firstWhere((element) => element.name == '首頁'),
          _pages.firstWhere((element) => element.name == 'QR掃描'),
          _pages.firstWhere((element) => element.name == '登入')
        ];
      }
    }
  }
}
