import 'dart:typed_data';

import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

class StorageFirebase {
  static Future<String?> uploadProfilePhoto(
      {required context, required Uint8List data}) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final mountainsRef = storageRef
          .child("profilePhotos/${AuthFirebase().getUid}/pp.jpg");

      await mountainsRef.putData(data);
      // Upload raw data.
      await mountainsRef.putData(data);

      return await mountainsRef.getDownloadURL();
    } on firebase_core.FirebaseException {
      SimpleUIs().showSnackBar(context, "Error");
      return null;
    }
  }
}
