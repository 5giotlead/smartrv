import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/widgets/primary_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ManageTypePage extends StatefulWidget {
  const ManageTypePage({super.key});

  @override
  State<StatefulWidget> createState() => _ManageTypeState();
}

class _ManageTypeState extends State<ManageTypePage> {
  final _dio = Modular.get<Dio>();
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _saveRVType() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final data = _formKey.currentState!.value;
      try {
        await _dio.post<dynamic>('/smartrv/type', data: data);
        Modular.to.navigate('/home');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '車款管理',
          style: TextStyle(
            height: 1.4,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 219, 217, 217),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FormBuilder(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 27),
              FormBuilderTextField(
                name: 'typeName',
                decoration: const InputDecoration(
                  labelText: '車款名稱',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: '車款名稱為必填欄位！',
                  ),
                ]),
                keyboardType: TextInputType.text,
              ),
              FormBuilderTextField(
                name: 'filenames',
                decoration: const InputDecoration(
                  labelText: '車款圖片',
                ),
                keyboardType: TextInputType.text,
              ),
              FormBuilderTextField(
                name: 'price',
                decoration: const InputDecoration(
                  labelText: '車款租金',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.zero,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: PrimaryButton(
                        '送出',
                        _saveRVType,
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      child: PrimaryButton(
                        '重設',
                        () {
                          _formKey.currentState!.reset();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
