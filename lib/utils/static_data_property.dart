import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/widgets/models/property.dart';
import 'package:flutter_rv_pms/widgets/rv_kind.dart';
import 'package:flutter_rv_pms/shared/models/telemetry.dart';

class StaticData {
  static final List<HouseProperty> HouseCardList = [
    HouseProperty(
      location: '桃園市 龜山區',
      // type: 'NOMADIC 5',
      // imagePath: 'assets/images/rv1.png',
      imagePath: 'bb63eb18-9fa9-42fd-a8be-b6bcbd2c25ee.jpg',
      name: r'遊牧旅居車',
    ),
    HouseProperty(
      location: '桃園市 龜山區',
      // type: 'NOMADIC 5.8',
      imagePath: 'ca1e7bf2-f2fc-4955-92f4-0a31140909ea.jpg',
      name: '遊牧款豪華衛浴車',
    ),
  ];

  static final List<HouseProperty> HouseCardList2 = [
    HouseProperty(
      location: '桃園市 龜山區',
      // type: 'NOMADIC 5',
      // imagePath: 'assets/images/rv1.png',
      imagePath: 'bb63eb18-9fa9-42fd-a8be-b6bcbd2c25ee.jpg',
      name: r'遊牧旅居車',
    ),
    HouseProperty(
      location: '桃園市 龜山區',
      // type: 'NOMADIC 5.8',
      imagePath: 'ca1e7bf2-f2fc-4955-92f4-0a31140909ea.jpg',
      name: '遊牧款豪華衛浴車',
    ),
  ];

  // static final List<RvKind> RvKindList = [
  //   RvKind(
  //     '北部',
  //     const Icon(Icons.home),
  //     callBack: (text) async {
  //       print(await text);
  //     },
  //   ),
  //   RvKind(
  //     '中部',
  //     const Icon(Icons.ac_unit),
  //     callBack: (text) async {
  //       print(await text);
  //     },
  //   ),
  //   RvKind(
  //     '南部',
  //     const Icon(Icons.access_time),
  //     callBack: (text) async {
  //       print(await text);
  //     },
  //   ),
  //   RvKind(
  //     '東部',
  //     const Icon(Icons.account_balance_rounded),
  //     callBack: (text) async {
  //       print(await text);
  //     },
  //   ),
  //   RvKind(
  //     '離島',
  //     const Icon(Icons.accessibility_new_sharp),
  //     callBack: (text) async {
  //       print(await text);
  //     },
  //   ),
  // ];
}
