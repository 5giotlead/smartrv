import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/shared/models/camp.dart';
import 'package:flutter_rv_pms/shared/models/comment.dart';
import 'package:flutter_rv_pms/shared/models/ord.dart';
import 'package:flutter_rv_pms/shared/models/rv.dart';
import 'package:flutter_rv_pms/shared/models/rv_type.dart';
import 'package:flutter_rv_pms/widgets/primary_button.dart';
import 'package:thingsboard_client/thingsboard_client.dart';

class RentPage extends StatefulWidget {
  const RentPage({super.key, String? typeId, String? assetId});

  @override
  State<StatefulWidget> createState() => _RentPageState();
}

class _RentPageState extends State<RentPage> {
  final typeId = Modular.args.queryParams['typeId'];
  final assetId = Modular.args.queryParams['assetId'];
  final _tbClient = Modular.get<ThingsboardClient>();
  final _dio = Modular.get<Dio>();
  final _formKey = GlobalKey<FormState>();
  List<Camp> campList = [];
  Camp camp = Camp('', '', '', '', '');
  List<RVType> rvTypeList = [];
  RVType rvType = RVType('', '', [], 0);
  late TextEditingController rvController;
  late TextEditingController campController;
  late TextEditingController desController;
  late TextEditingController rvTypeController;
  late TextEditingController assetController;

  void initControllers() {
    rvController = TextEditingController();
    campController = TextEditingController();
    desController = TextEditingController();
    rvTypeController = TextEditingController(text: typeId);
    assetController = TextEditingController(text: assetId);
  }

  Future<void> _saveRV() async {
    if (_formKey.currentState!.validate()) {
      final data = jsonEncode({
        'name': rvController.text,
        'description': desController.text,
        'assetId': assetId ?? '',
        'type': {'id': rvType.id},
        'camp': {'id': camp.id},
        'comments': <Comment>[],
        'ords': <Ord>[],
      });
      try {
        await _dio.post<String>('/smartrv/rv', data: data);
      } catch (e) {
        if (kDebugMode) {
          print('error');
        }
      } finally {
        Modular.to.navigate('/home');
      }
    }
  }

  Future<void> getCampList() async {
    final res = await _dio.get<List<dynamic>>('/smartrv/camp');
    setState(() {
      for (var i = 0; i < res.data!.length; i++) {
        campList.add(Camp.fromJson(res.data![i] as Map<String, dynamic>));
        camp = campList.first;
      }
    });
  }

  Future<void> getRVTypeList() async {
    final res = await _dio.get<List<dynamic>>('/smartrv/type');
    setState(() {
      for (var i = 0; i < res.data!.length; i++) {
        rvTypeList.add(RVType.fromJson(res.data![i] as Map<String, dynamic>));
      }
      if (typeId != null) {
        rvType = rvTypeList.firstWhere((element) => element.id == typeId);
      } else {
        rvType = rvTypeList.first;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getCampList();
    getRVTypeList();
    initControllers();
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
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () => Modular.to.pop(),
        // ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 219, 217, 217),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ListBody(
          children: [
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: '請填寫以下資料...',
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
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 247, 249, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.only(left: 24, right: 32),
                    child: DropdownButton<RVType>(
                      isExpanded: true,
                      value: rvType,
                      icon: const Icon(Icons.arrow_downward),
                      // elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      onChanged: (typeId != null)
                          ? null
                          : (RVType? newValue) {
                              setState(() {
                                rvType = newValue!;
                              });
                            },
                      items: rvTypeList
                          .map<DropdownMenuItem<RVType>>((RVType rvType) {
                        return DropdownMenuItem<RVType>(
                          value: rvType,
                          child: Text(
                            rvType.typeName!,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 247, 249, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.only(left: 24, right: 32),
                    child: DropdownButton<Camp>(
                      isExpanded: true,
                      value: camp,
                      icon: const Icon(Icons.arrow_downward),
                      // elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(
                        height: 1,
                        color: Colors.black,
                      ),
                      onChanged: (Camp? newValue) {
                        setState(() {
                          camp = newValue!;
                        });
                      },
                      items: campList.map<DropdownMenuItem<Camp>>((Camp camp) {
                        return DropdownMenuItem<Camp>(
                          value: camp,
                          child: Text(
                            camp.name!,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 247, 249, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: rvController,
                      decoration: const InputDecoration(
                        hintText: '營車名',
                        hintStyle: TextStyle(
                          fontSize: 16,
                          color: Color.fromRGBO(124, 124, 124, 1),
                          fontWeight: FontWeight.w600,
                        ),
                        suffixIcon: Icon(
                          Icons.car_rental,
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
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 247, 249, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: desController,
                      decoration: const InputDecoration(
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
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(247, 247, 249, 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: assetController,
                      // enabled: assetId?.isEmpty,
                      decoration: const InputDecoration(
                        hintText: '營車產品序號',
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
                        final numberList = value!.split('-');
                        if (value.isEmpty) {
                          return '請輸入字元...';
                        } else if (numberList.length != 5 ||
                            numberList[0].length != 8 ||
                            numberList[1].length != 4 ||
                            numberList[2].length != 4 ||
                            numberList[3].length != 4 ||
                            numberList[4].length != 12) {
                          return '格式不符，請重新輸入！';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Image.network(
                      'https://rv.5giotlead.com/static/all/7d3cdf73-2761-498c-af2f-dd9fd5a11787.jpg',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: PrimaryButton('送出', _saveRV),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
