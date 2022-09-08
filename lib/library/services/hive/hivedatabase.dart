import 'package:hive_flutter/adapters.dart';

class HiveDatabase {
  var boxFaves = Hive.box("faves");
  List? faves;

  //FAVES/////////////////////////////////////////////

  bool checkFave(String id) {
    faves ??= boxFaves.get("_admin_code_admin_faves_") ?? [];

    return faves!.contains(id);
  }

  void addFave(String id) {
    faves ??= boxFaves.get("_admin_code_admin_faves_") ?? [];

    faves!.insert(0, id);

    boxFaves.put("_admin_code_admin_faves_", faves);
  }

  void removeFave(String id) {
    faves ??= boxFaves.get("_admin_code_admin_faves_") ?? [];

    faves!.remove(id);

    boxFaves.put("_admin_code_admin_faves_", faves);
  }
}
