import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/page/home/provider/qr_scan.dart';
import 'package:flutter_rv_pms/page/home/widgets/avatar.dart';
import 'package:flutter_rv_pms/page/home/widgets/home_search.dart';
import 'package:flutter_rv_pms/shared/models/rv.dart';
import 'package:flutter_rv_pms/utils/static_data_property.dart';
import 'package:flutter_rv_pms/page/home/widgets/rv_card.dart';
import 'package:flutter_rv_pms/widgets/rv_kind.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final _authStore = Modular.get<AuthStore>();

  @override
  bool mounted = false;

  @override
  void initState() {
    super.initState();
    mounted = true;
    _authStore.observer(
      onState: (state) => {
        if (mounted) {setState(() {})}
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    mounted = false;
  }

  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true; // After Build Widget
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 217, 217),
        appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                tooltip: 'menu',
              );
            },
          ),
          title: const Text('RV'),
          actions: <Widget>[
            LayoutBuilder(builder: (context, constraints) {
              if (_authStore.state) {
                return IconButton(
                  icon: const Icon(Icons.logout),
                  tooltip: 'Logout',
                  onPressed: () {
                    Modular.to.navigate('/auth/logout');
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.login),
                  tooltip: 'Login',
                  onPressed: () {
                    Modular.to.navigate('/auth/login');
                  },
                );
              }
            }),
            LayoutBuilder(builder: (context, constraints) {
              if (_authStore.state) {
                return IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Control',
                  onPressed: () {
                    Modular.to.navigate('/member/control');
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Search')));
                  },
                );
              } else {
                return Container();
              }
            }),
            IconButton(
              icon: const Icon(Icons.qr_code_scanner),
              tooltip: 'QR Code Scanner',
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
            ),
            LayoutBuilder(builder: (context, constraints) {
              return (_authStore.state)
                  ? Avatar('assets/images/lady.png')
                  : Avatar('assets/images/dp.png');
            }),
            // IconButton(
            //   icon: const Icon(Icons.shopping_bag),
            //   tooltip: 'Booking',
            //   onPressed: () {
            //     Modular.to.navigate('/member/shopping');
            //   },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.ac_unit_rounded),
            //   onPressed: () {
            //     Modular.to.navigate('/passcode');
            //   },
            // ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        //bottomNavigationBar: BottomNavBar(),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: HomeSearch(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Container(
                margin: EdgeInsets.only(top: 24),
                child: RvKindList(),
              ),
            ),
          )
        ]));
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => QRScan(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

dynamic getData;

class RvKindList extends StatefulWidget {
  const RvKindList({super.key});

  @override
  State<StatefulWidget> createState() => _RvKindListState();
}

class _RvKindListState extends State<RvKindList> {
  final GlobalKey<_RvListState> key = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: <Widget>[
              RvKind(
                '北部',
                const Icon(Icons.temple_buddhist),
                callBack: (text) async {
                  getData = await text;
                  key.currentState?.changeState();
                  // print(await text);
                },
              ),
              RvKind(
                '中部',
                const Icon(Icons.hiking),
                callBack: (text) async {
                  getData = await text;
                  key.currentState?.changeState();
                  // print(await text);
                },
              ),
              RvKind(
                '南部',
                const Icon(Icons.sunny),
                callBack: (text) async {
                  getData = await text;
                  key.currentState?.changeState();
                  // print(await text);
                },
              ),
              RvKind(
                '東部',
                const Icon(Icons.bike_scooter),
                callBack: (text) async {
                  getData = await text;
                  key.currentState?.changeState();
                  // print(await text);
                },
              ),
              RvKind(
                '離島',
                const Icon(Icons.water),
                callBack: (text) async {
                  getData = await text;
                  key.currentState?.changeState();
                  // print(await text);
                },
              ),
            ]),
          ),
        ),
        Expanded(
            flex: 8,
            child: RvList(
              key: key,
            ))
      ],
    );
  }
}

class RvList extends StatefulWidget {
  const RvList({super.key});

  @override
  State<StatefulWidget> createState() => _RvListState();
}

class _RvListState extends State<RvList> {
  final _dio = Modular.get<Dio>();
  List<dynamic> rvList = [];

  Future<void> getRVList() async {
    final res = await _dio.get<List<dynamic>>('/smartrv/rv');
    setState(() {
      rvList = res.data!;
    });
  }

  @override
  void initState() {
    super.initState();
    getRVList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      scrollDirection: Axis.vertical,
      children: [for (final rv in rvList) RVCard(rv)],
      // separatorBuilder: (BuildContext context, int index) {
      //   return const SizedBox(
      //     width: 20,
      //   );
      // },
      // Make the length our static data length
      // itemCount: StaticData.HouseCardList.length,
      // )
      // ,
    );
    return const SizedBox();
  }

  changeState() {
    setState(() {
      print(getData);
    });
  }
}
