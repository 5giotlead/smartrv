import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UploadPage extends StatelessWidget {
  UploadPage({super.key});

  final _dio = Modular.get<Dio>();
  final files = <PlatformFile>[];

  Future<void> selectFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      for (final file in result.files) {
        files.add(file);
      }
    } else {
      // User canceled the picker
    }
  }

  void uploadDialog(BuildContext context, String message) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('上傳檔案'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Modular.to.pop('OK'),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> uploadFile(
    BuildContext context,
    PlatformFile selectedFile,
  ) async {
    final file = MultipartFile.fromBytes(
      selectedFile.bytes!.toList(),
      filename: selectedFile.name,
    );
    final data = FormData.fromMap({'file': file});
    try {
      await _dio.post<dynamic>(
        '/smartrv/file',
        data: data,
        onSendProgress: (int sent, int total) =>
            print('${file.filename} ${sent / total * 100} %'),
      );
    } on DioError {
      uploadDialog(context, '${file.filename} 上傳失敗！');
    }
  }

  void confirmUpload(BuildContext context) {
    if (files.isNotEmpty) {
      for (final file in files) {
        uploadFile(context, file);
      }
      files.clear();
    } else {
      uploadDialog(context, '未選擇檔案！');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          onPressed: selectFiles,
          child: const Text('pick files'),
        ),
        MaterialButton(
          onPressed: () => confirmUpload(context),
          child: const Text('upload'),
        ),
      ],
    );
  }
}
