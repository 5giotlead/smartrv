import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/auth/auth_store.dart';
import 'package:flutter_rv_pms/page/home/widgets/qr_scan2.dart';
import 'package:flutter_rv_pms/page/home/widgets/avatar.dart';
import 'package:flutter_rv_pms/shared/models/rv.dart';
import 'package:flutter_rv_pms/shared/widgets/rv_card.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({super.key});

  @override
  State<StatefulWidget> createState() => _ManageState();
}

class _ManageState extends State<ManagePage> {
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
            tooltip: 'QR Code掃描',
            onPressed: () {
              Modular.to.pushNamed('/qr-scan');
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Container(
                margin: const EdgeInsets.only(top: 24),
                child: const RvList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Route<dynamic> _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => const QRScan2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0, 1);
      const end = Offset.zero;
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class RvList extends StatefulWidget {
  const RvList({super.key});

  @override
  State<StatefulWidget> createState() => _RvListState();
}

class _RvListState extends State<RvList> {
  final _tbClient = Modular.get<ThingsboardClient>();
  final _dio = Modular.get<Dio>();
  List<RV> rvList = [];

  Future<void> getRVList() async {
    var assetList;
    final user = _tbClient.getAuthUser();
    if (user != null) {
      (user.authority == Authority.TENANT_ADMIN)
          ? assetList = await _tbClient.get<dynamic>(
              '/api/tenant/assets?page=0&pageSize=10',
            )
          : assetList = await _tbClient.get<dynamic>(
              '/api/customer/${user.customerId}/assets?page=0&pageSize=10',
            );
    }
    final assets = assetList.data;
    if (assetList.data != null) {
      for (var i = 0; i < (assets['totalElements'] as int); i++) {
        if (assets['data'][i]['type'] == 'SmartRV') {
          final res = await _dio.get<List<dynamic>>(
            '/smartrv/rv?assetId=${assets['data'][i]['id']['id']}',
          );
          rvList.add(RV.fromJson(res.data![0] as Map<String, dynamic>));
        }
      }
      setState(() {});
    }
  }

  Future<void> deleteRV(String rvId) async {
    // await _dio.delete('/smartrv/rv/$rvId');
    // await getRVList();
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
        for (final rv in rvList)
          RVCard(
            rv: rv,
            type: 'manage',
          )
      ],
    );
    return const SizedBox();
  }
}
