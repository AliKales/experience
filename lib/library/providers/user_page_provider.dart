import 'package:experiences/library/models/model_user.dart';
import 'package:flutter/material.dart';

import '../services/firebase/auth_firebase.dart';
import '../services/firebase/firestore_firebase.dart';

class UserPageProvider with ChangeNotifier {
  ModelUser? user;

  Future<ModelUser?> setUserFromDB(context, [String? userID]) async {
    if (user != null) return user;
    var result = await FirestoreFirebase.getUser(
        context: context, id: userID ?? AuthFirebase().getUid);

    if (userID == null) user = result;

    return result;
  }

  void resetUser() {
    user = null;
  }

  ModelUser? get getUser => user;
}
