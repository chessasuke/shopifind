import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:universal_platform/universal_platform.dart';

class AppService {
  static Future<String?>? pickFileDesktop() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowedExtensions: ['csv'], type: FileType.custom);
    File? file;
    String? contents;
    if (result != null) {
      if (UniversalPlatform.isDesktop) {
        if (result.files.first.path != null) {
          if (result.files.first.extension == 'csv') {
            file = File(result.files.first.path!);
            try {
              contents = await file.readAsString();
              print('contents: $contents');
              return contents;
            } catch (e) {
              print("error in service_pickFile: $e");
            }
          }
        }
      } else if (UniversalPlatform.isWeb) {
        if (result.files.first.bytes != null) {
          contents = utf8.decode(result.files.first.bytes!.toList());
          return contents;
        }
      }
    } else {
      print('user didnt pick a file');
    }
    return contents;
  }
}
