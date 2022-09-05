import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

typedef CallBack = dynamic Function(dynamic);

class RvKind extends StatelessWidget {
  RvKind(this.region, this.icon, {super.key, required this.callBack});

  final String region;
  final Icon icon;
  final CallBack callBack;
  final _dio = Modular.get<Dio>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 70,
        width: 70,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Or Changed as  photo
            // CircleAvatar(
            //   backgroundColor: Colors.transparent,
            //   // radius: 20.0,
            //   backgroundImage: AssetImage(icon),
            // ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(200, 121, 131, 124),
                  shape: BoxShape.rectangle),
              child: IconButton(
                icon: icon,
                tooltip: 'Search',
                onPressed: () {
                  this.callBack(getRvList());
                  // ScaffoldMessenger.of(context)
                  //     .showSnackBar(const SnackBar(content: Text('Search')));
                },
              ),
            ),
            SizedBox(
              height: 2,
            ),
            RichText(text: TextSpan(text: region)),
          ],
        ),
      ),
    );
  }

  Future<Object> getRvList() async {
    try {
      return await _dio.get('/smartrv/camp?region=$region');
    } catch (e) {
      print(e);
      return 'error';
    }
  }
}
