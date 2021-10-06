import 'dart:convert';
import 'dart:io';

import 'package:shopifind/model/canv_object_model.dart';
import 'package:shopifind/model/product_model.dart';
import 'package:shopifind/model/store_model.dart';
import 'package:file_picker/file_picker.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<String> uploadToSever(StoreModel store,
      List<ProductModel> products, List<CanvObjectModel> objects) async {
    String committed = 'ok';
    WriteBatch batch = FirebaseFirestore.instance.batch();
    store = store.copyWith(products: products, objects: objects);
    try {
      /// upload store info to the cloud, values not referenced remain untouched
      batch.set(FirebaseFirestore.instance.collection('stores').doc(store.id),
          store.toJson(), SetOptions(merge: true));

      /// commit/upload to firestore
      await batch.commit();
      print('data committed');
    } catch (e) {
      committed = e.toString();
      print('[service upload product error] $e');
    }
    return committed;
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> fetchStores() async {
    final query = await FirebaseFirestore.instance.collection('stores').get();
    return query;
  }

  static Future<String> updateStoreDescription(
      String id, String newDescription) async {
    String statusMsg = 'ok';

    try {
      await FirebaseFirestore.instance.collection('stores').doc(id).update({'description': newDescription});
    } catch (e) {
      print('error deleting store: $e');
      statusMsg = e.toString();
    }
    return statusMsg;
  }

  static Future<String> deleteStore(String id) async {
    String statusMsg = 'ok';

    try {
      await FirebaseFirestore.instance.collection('stores').doc(id).delete();
    } catch (e) {
      print('error deleting store: $e');
      statusMsg = e.toString();
    }
    return statusMsg;
  }
}
