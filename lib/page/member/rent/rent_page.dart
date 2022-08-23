import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/widgets/input_widget.dart';
import 'package:flutter_rv_pms/widgets/primary_button.dart';

class RentPage extends StatefulWidget {
  RentPage({super.key, required typeId, required assetId});

  @override
  State<StatefulWidget> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  final typeId = Modular.args.params['typeId'];
  final assetId = Modular.args.params['assetId'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 219, 217, 217),
        // bottomNavigationBar: BottomNavBar(),
        body: SingleChildScrollView(
            child: ListBody(children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "出租\n",
                  style: TextStyle(
                    height: 1.4,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: "請填寫以下資料...",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          InputWidget("房名", false, Icons.door_back_door_outlined),
          InputWidget("營區", false, Icons.landscape_outlined),
          Container(
            width: 200,
            height: 200,
            // color: Colors.red,
            child: const Image(
              image: NetworkImage(
                  'https://media.discordapp.net/attachments/992357029064740944/1003581864969240658/unknown.png?width=938&height=703'),
            ),
          ),
          InputWidget("圖片", false, Icons.photo),
          InputWidget("描述", false, Icons.note), // selectable param
          PrimaryButton(
            '送出',
            () {
              print('submit');
            },
          ),
          PrimaryButton(
            '清除',
            () {
              print('clear');
            },
          ),
        ])));
  }
}
