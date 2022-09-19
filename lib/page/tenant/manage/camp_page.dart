import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/l10n/l10n.dart';
import 'package:flutter_rv_pms/shared/models/rv_file.dart';
import 'package:flutter_rv_pms/widgets/primary_button.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ManageCampPage extends StatefulWidget {
  const ManageCampPage({super.key});

  @override
  State<StatefulWidget> createState() => _ManageCampState();
}

class _ManageCampState extends State<ManageCampPage> {
  final _dio = Modular.get<Dio>();
  final _formKey = GlobalKey<FormBuilderState>();
  final regionList = <String>['北部', '中部', '南部', '東部', '離島'];
  final fileList = <RVFile>[];
  bool _regionHasError = false;
  bool _fileHasError = false;

  Future<void> _getFiles() async {
    final res = await _dio.get<List<dynamic>>('/smartrv/file?block=camp');
    setState(() {
      for (var i = 0; i < res.data!.length; i++) {
        fileList.add(RVFile.fromJson(res.data![i] as Map<String, dynamic>));
      }
    });
  }

  Future<void> _saveCamp() async {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      final data = jsonEncode(_formKey.currentState!.value);
      try {
        await _dio.post('/smartrv/camp', data: data);
        Modular.to.navigate('/home');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getFiles();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '營區管理',
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
              FormBuilderDropdown<String>(
                name: 'region',
                decoration: const InputDecoration(
                  labelText: '營地區域',
                ),
                validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()],
                ),
                items: regionList
                    .map(
                      (region) => DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: region,
                        child: Text(region),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _regionHasError =
                        !(_formKey.currentState?.fields['region']?.validate() ??
                            false);
                  });
                },
                valueTransformer: (val) => val?.toString(),
              ),
              FormBuilderTextField(
                name: 'name',
                decoration: const InputDecoration(
                  labelText: '營區名稱',
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(
                    errorText: '營區名稱為必填欄位！',
                  ),
                ]),
                keyboardType: TextInputType.text,
              ),
              FormBuilderTextField(
                name: 'city',
                decoration: const InputDecoration(
                  labelText: '所在城市',
                ),
                keyboardType: TextInputType.number,
              ),
              FormBuilderDropdown<String>(
                name: 'fileName',
                decoration: const InputDecoration(
                  labelText: '營區圖片',
                ),
                validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required()],
                ),
                items: fileList
                    .map(
                      (file) => DropdownMenuItem(
                        alignment: AlignmentDirectional.center,
                        value: file.id,
                        child: ListTile(
                          leading: Image.network(
                            'https://rv.5giotlead.com/static/camp/${file.id}.${file.mediaType}',
                          ),
                          title: Text(file.originalName!),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _fileHasError = !(_formKey.currentState?.fields['fileName']
                            ?.validate() ??
                        false);
                  });
                },
                valueTransformer: (val) => val?.toString(),
              ),
              const SizedBox(height: 30),
              Container(
                margin: EdgeInsets.zero,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: PrimaryButton(
                        '送出',
                        _saveCamp,
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
