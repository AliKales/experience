import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experiences/library/funcs.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/models/model_user.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/services/firebase/storage_firebase.dart';
import 'package:flutter/cupertino.dart';

class FirestoreFirebase {
  static DocumentSnapshot<Object?>? documentSnapshot;

  //AUTH PART

  ///[getUser] [username] and [id] shouldnt be given at the same time for but if its given
  ///then it search by [username]
  static Future<ModelUser?> getUser({
    required context,
    String? username,
    String? id,
  }) async {
    Map<String, dynamic> map;

    if (username != null) {
      var result = await FirebaseFirestore.instance
          .collection("users")
          .where("username", isEqualTo: username.trim())
          .limit(1)
          .get();
      if (result.docs.isEmpty) return null;
      map = result.docs.first.data();
    } else {
      var result =
          await FirebaseFirestore.instance.collection("users").doc(id).get();
      if (!result.exists) return null;
      map = result.data()!;
    }

    return ModelUser.fromJson(map);
  }

  static Future<bool> setUser(
      {required context, required ModelUser modelUser}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(modelUser.id!)
        .set(modelUser.toJson());

    return true;
  }
  //AUTH PART

  static Future<List<ModelItemExperience>?> getItemsExperiencesForProfile(
      List<String> ids) async {
    if (ids.isEmpty) return null;
    List<ModelItemExperience> list = [];

    var result = await FirebaseFirestore.instance
        .collection("experiences")
        .limit(5)
        .get();
    if (result.docs.isEmpty) return null;

    for (var doc in result.docs) {
      list.add(ModelItemExperience.fromJson(doc.data()));
    }

    return list;
  }

  static Future<bool> setProfilePicture(
      {required context, required String url}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthFirebase().getUid)
        .update({'photoURL': url});

    return true;
  }

  static Future<bool> addExperienceToUser(
      {required context, required List elements}) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(AuthFirebase().getUid)
        .update({'postIds': FieldValue.arrayUnion(elements)});

    return true;
  }

  static Future<bool> shareExperience({
    required context,
    required ModelItemExperience experience,
    required String path,
  }) async {
    await FirebaseFirestore.instance
        .collection("experiences")
        .doc(path)
        .set(experience.toJson());

    return true;
  }

  static Future<List<ModelItemExperience>> getExperiences(
      {required context}) async {
    final QuerySnapshot result;
    List<ModelItemExperience> listToReturn = [];

    if (FirestoreFirebase.documentSnapshot == null) {
      result = await FirebaseFirestore.instance
          .collection("experiences")
          .limit(10)
          .get();
    } else {
      result = await FirebaseFirestore.instance
          .collection("experiences")
          .startAfterDocument(FirestoreFirebase.documentSnapshot!)
          .limit(10)
          .get();
    }

    for (var i = 0; i < result.docs.length; i++) {
      var element = result.docs[i];
      listToReturn.add(
          ModelItemExperience.fromJson(element.data() as Map<String, dynamic>));

      if (i == result.docs.length - 1) {
        FirestoreFirebase.documentSnapshot = element;
      }
    }

    return listToReturn;
  }
}
