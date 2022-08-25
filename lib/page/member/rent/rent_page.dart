import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/widgets/input_widget.dart';
import 'package:flutter_rv_pms/widgets/primary_button.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class RentPage extends StatefulWidget {
  RentPage({super.key, String? typeId, String? assetId});

  @override
  State<StatefulWidget> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  final typeId = Modular.args.queryParams['typeId'];
  final assetId = Modular.args.queryParams['assetId'];
  final _tbClient = Modular.get<ThingsboardClient>();
  final _dio = Modular.get<Dio>();

  Future<void> _saveRV() async {
    final data = jsonEncode({
      'name': '150',
      'description': 'TEST',
      'assetId': assetId != null ? assetId : '',
      'type': {
        'id': typeId != null ? typeId : '7c2ad09f-0242-4fee-a006-0cd720ec9e2b'
      },
      'camp': {'id': 'f6fd537e-16e7-4b6f-ac15-6c8bf57349df'},
    });
    print(await _dio.post<String>('/smartrv/rv', data: data));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '出租',
            style: TextStyle(
              height: 1.4,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color.fromARGB(255, 219, 217, 217),
        // bottomNavigationBar: BottomNavBar(),
        body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: ListBody(children: [
              RichText(
                text: TextSpan(
                  children: [
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
              InputWidget("描述", false, Icons.note),
              InputWidget("圖片", false, Icons.photo),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: Image.network(
                  'https://media.discordapp.net/attachments/992357029064740944/1003581864969240658/unknown.png?width=938&height=703',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: PrimaryButton(
                        '送出',
                        _saveRV,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: PrimaryButton(
                        '清除',
                        () {
                          print('clear');
                        },
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}
