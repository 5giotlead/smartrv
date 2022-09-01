import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/page/member/order/widgets/rv_item.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 219, 217, 217),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: 'xxx',
              );
            },
          ),
          title: const Text('訂單'),
          actions: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              child: IconButton(
                icon: const Icon(Icons.access_time_filled_outlined),
                tooltip: 'aa',
                onPressed: () {
                  // Modular.to.navigate('/auth/logout');
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('Home')));
                },
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: ListView(
          padding: EdgeInsets.zero,
          primary: false,
          shrinkWrap: true,
          children: [
            RvItem(),
            RvItem(),
          ],
        ));
  }
}
