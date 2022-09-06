import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/page/home/widgets/avatar.dart';
import 'package:flutter_rv_pms/page/home/widgets/home_search.dart';
import 'package:flutter_rv_pms/shared/models/rv.dart';
import 'package:flutter_rv_pms/shared/widgets/rv_card.dart';
import 'package:flutter_rv_pms/widgets/rv_kind.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final _authStore = Modular.get<AuthStore>();

  void reBuild() {
    setState(() {});
  }

  void initListener() {
    _authStore.authNotifier.addListener(reBuild);
  }

  void disposeListener() {
    _authStore.authNotifier.removeListener(reBuild);
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
    // debugPaintSizeEnabled = true; // After Build Widget
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 217, 217),
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: 'menu',
            );
          },
        ),
        title: const Text('RV'),
        actions: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) {
              return _authStore.state
                  ? IconButton(
                      icon: const Icon(Icons.logout),
                      tooltip: 'Logout',
                      onPressed: () {
                        Modular.to.navigate('/auth/logout');
                      },
                    )
                  : IconButton(
                      icon: const Icon(Icons.login),
                      tooltip: 'Login',
                      onPressed: () {
                        Modular.to.navigate('/auth/login');
                      },
                    );
            },
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            tooltip: 'QR Code Scanner',
            onPressed: () {
              Modular.to.pushNamed('/qrscan');
            },
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return (_authStore.state)
                  ? Avatar('assets/images/dp.png')
                  : Avatar('assets/images/account_circle.png');
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      //bottomNavigationBar: BottomNavBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: HomeSearch(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Container(
                margin: const EdgeInsets.only(top: 24),
                child: const RvKindList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
            child: Row(
              children: <Widget>[
                RvKind(
                  '北部',
                  const Icon(Icons.temple_buddhist),
                  callBack: (text) async {
                    key.currentState?.changeState();
                  },
                ),
                RvKind(
                  '中部',
                  const Icon(Icons.hiking),
                  callBack: (text) async {
                    key.currentState?.changeState();
                  },
                ),
                RvKind(
                  '南部',
                  const Icon(Icons.sunny),
                  callBack: (text) async {
                    key.currentState?.changeState();
                  },
                ),
                RvKind(
                  '東部',
                  const Icon(Icons.bike_scooter),
                  callBack: (text) async {
                    key.currentState?.changeState();
                  },
                ),
                RvKind(
                  '離島',
                  const Icon(Icons.water),
                  callBack: (text) async {
                    key.currentState?.changeState();
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 8,
          child: RvList(
            key: key,
          ),
        )
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
  List<RV> rvList = [];

  Future<void> getRVList() async {
    final res = await _dio.get<List<dynamic>>('/smartrv/rv');
    for (var i = 0; i < res.data!.length; i++) {
      rvList.add(RV.fromJson(res.data![i] as Map<String, dynamic>));
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getRVList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (final rv in rvList.reversed)
          RVCard(
            rv: rv,
            type: 'view',
          )
      ],
    );
  }

  void changeState() {}
}
