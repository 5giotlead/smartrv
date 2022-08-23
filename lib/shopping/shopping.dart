import 'package:flutter/material.dart';
import 'package:flutter_rv_pms/shopping/widgets/rv_item.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  State<ShoppingPage> createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 217, 217),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                tooltip: 'xxx',
              );
            },
          ),
          title: const Text('訂單'),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
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
          scrollDirection: Axis.vertical,
          children: [
            RvItem(),
            RvItem(),
            RvItem(),
            RvItem(),
            RvItem(),
            RvItem(),
            RvItem(),
            RvItem(),
            RvItem(),
          ],
        ));
  }
}
