import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageClient {
  FirebaseStorage _storage = FirebaseStorage.instance;

  // Making Singleton
  static StorageClient _instance = StorageClient.internal();

  StorageClient.internal();

  factory StorageClient() => _instance;

  StorageReference storageReference;
  StorageUploadTask storageUploadTask;

  Future<String> uploadFile(File file, String folder, String ext) async {
    final String uuid = Uuid().v1(); // random ID
    final StorageReference ref =
    _storage.ref().child('$folder').child('$uuid.$ext');
    final StorageUploadTask uploadTask = ref.putFile(
      file,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'ProfileImages': '$folder'},
        contentType: 'image/$ext',
      ),
    );

    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }
}
