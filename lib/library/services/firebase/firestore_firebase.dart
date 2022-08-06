import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/models/model_user.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';

class FirestoreFirebase {
  static DocumentSnapshot<Object?>? documentSnapshot;
  static DocumentSnapshot<Object?>? documentSnapshotUserPage;

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

    QuerySnapshot? result;

    if (FirestoreFirebase.documentSnapshotUserPage == null) {
      result = await FirebaseFirestore.instance
          .collection("experiences")
          .where("id", arrayContainsAny: ids)
          .limit(5)
          .get();
    } else {
      result = await FirebaseFirestore.instance
          .collection("experiences")
          .startAfterDocument(FirestoreFirebase.documentSnapshotUserPage!)
          .where("id", arrayContainsAny: ids)
          .limit(5)
          .get();
    }

    if (result.docs.isEmpty) return null;

    for (var i = 0; i < result.docs.length; i++) {
      list.add(ModelItemExperience.fromJson(
          result.docs[i].data() as Map<String, dynamic>));

      if (i == result.docs.length - 1) {
        FirestoreFirebase.documentSnapshot = result.docs[i];
      }
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

  static Future<List<ModelUser>> fetchUsersByUsername({
    required context,
    required String username,
  }) async {
    var result = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isGreaterThanOrEqualTo: username)
        .where("username", isLessThanOrEqualTo: '$username\uf8ff')
        .limit(3)
        .get();

    List<ModelUser> results = [];

    for (var element in result.docs) {
      results.add(ModelUser.fromJson(element.data()));
    }

    return results;
  }
}
