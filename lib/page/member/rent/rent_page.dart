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
  final _formKey = GlobalKey<FormState>();
  TextEditingController rvController = TextEditingController();
  TextEditingController campController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  Future<void> _saveRV() async {
    if (_formKey.currentState!.validate()) {
      print(rvController.text);
      print(campController.text);
      print(desController.text);
      print(photoController.text);
      final data = jsonEncode({
        'name': '$rvController.text',
        'description': '$desController.text',
        'assetId': assetId != null ? assetId : '',
        'filenames': [photoController.text],
        'type': {
          'id': typeId != null ? typeId : '7c2ad09f-0242-4fee-a006-0cd720ec9e2b'
        },
        'camp': {
          'id': 'f6fd537e-16e7-4b6f-ac15-6c8bf57349df',
          'name': '$campController.text',
        },
      });
      print(await _dio.post<String>('/smartrv/rv', data: data));
      ClearText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            '上架',
            style: TextStyle(
              height: 1.4,
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Modular.to.pop(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color.fromARGB(255, 219, 217, 217),
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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 247, 249, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: rvController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '營車名',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(124, 124, 124, 1),
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon: Icon(
                            Icons.door_back_door_outlined,
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請輸入字元...';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 247, 249, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: campController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '營區',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(124, 124, 124, 1),
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon: Icon(
                            Icons.landscape_outlined,
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請輸入字元...';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 247, 249, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: desController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '描述',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(124, 124, 124, 1),
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon: Icon(
                            Icons.note,
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請輸入字元...';
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(247, 247, 249, 1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFormField(
                        controller: photoController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '圖片',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(124, 124, 124, 1),
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon: Icon(
                            Icons.photo,
                            color: Color.fromRGBO(105, 108, 121, 1),
                          ),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '請輸入字元...';
                          }
                          return null;
                        },
                      ),
                    ),
                    // InputWidget("營區", false, Icons.landscape_outlined, false),
                    // InputWidget("描述", false, Icons.note, false),
                    // InputWidget("圖片", false, Icons.photo, false),
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
                            child: PrimaryButton('送出', _saveRV),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: PrimaryButton('清除', ClearText),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ])));
  }

  ClearText() {
    rvController.text = '';
    campController.text = '';
    desController.text = '';
    photoController.text = '';
  }
}
