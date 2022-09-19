import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rv_pms/shared/models/rv_file.dart';
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
  final fileList = <RVFile>[];
  bool _fileHasError = false;

  Future<void> _getFiles() async {
    final res = await _dio.get<List<dynamic>>('/smartrv/file?block=rv');
    setState(() {
      for (var i = 0; i < res.data!.length; i++) {
        fileList.add(RVFile.fromJson(res.data![i] as Map<String, dynamic>));
      }
    });
  }

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
  void initState() {
    super.initState();
    _getFiles();
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
              FormBuilderDropdown<String>(
                name: 'filenames',
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
                            'https://rv.5giotlead.com/static/rv/${file.id}.${file.mediaType}',
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
