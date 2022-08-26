import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/page/home/provider/qr_scan.dart';
import 'package:flutter_rv_pms/page/home/widgets/home_search.dart';
import 'package:flutter_rv_pms/page/page_store.dart';
import 'package:flutter_rv_pms/utils/static_data_property.dart';
import 'package:flutter_rv_pms/widgets/house_card.dart';
import 'package:flutter_rv_pms/widgets/rv_kind.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/page/home/widgets/avatar.dart';

class HomePage2 extends StatelessWidget {
  HomePage2({super.key});
  final _dio = Modular.get<AuthStore>();

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
          title: const Text('RV - Rent Out'),
          actions: <Widget>[
            LayoutBuilder(builder: (context, constraints) {
              if (_dio.state) {
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
              if (_dio.state) {
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
              return (_dio.state)
                  ? Avatar('assets/images/lady.png')
                  : Avatar('assets/images/dp.png');
            }),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        //bottomNavigationBar: BottomNavBar(),
        body: Column(children: [
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
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return HouseCard(
          StaticData.HouseCardList[index],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(
          width: 20,
        );
      },
      // Make the length our static data length
      itemCount: StaticData.HouseCardList.length,
    );
  }

  changeState() {
    setState(() {
      print(getData);
    });
  }
}
