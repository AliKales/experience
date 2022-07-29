import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:flutter/material.dart';
import 'package:money_formatter/money_formatter.dart';

class Funcs {
  void navigatorPushReplacement(context, page) {
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => page);
    Navigator.pushReplacement(context, route);
  }

  String formatMoney(double amount) {
    MoneyFormatter fmf = MoneyFormatter(amount: amount);
    return fmf.output.symbolOnLeft.replaceAll(" ", "");
  }

  bool checkIfTECsEmpty(List<TextEditingController> listTECs) {
    for (var tEC in listTECs) {
      if (tEC.text.trim() == "") {
        return false;
      }
    }

    return true;
  }

  DateTime getGMTDateTimeNow() {
    int iS = DateTime.now().timeZoneOffset.inSeconds;
    return DateTime.now().subtract(Duration(seconds: iS));
  }

  DateTime? getFixedDateTime(DateTime? dT) {
    int iS = DateTime.now().timeZoneOffset.inSeconds;
    return dT?.add(Duration(seconds: iS));
  }

  String getIdByTime() {
    DateTime dT = getGMTDateTimeNow();
    return DateTime(4000).difference(dT).inSeconds.toString() +
        AuthFirebase().getEmail!.split("@").first;
  }

  String formatDate(DateTime dt) {
    String month = dt.month.toString();
    if (month.length == 1) {
      month = "0$month";
    }
    return "${dt.day}.$month.${dt.year} ${dt.hour}:${dt.minute}";
  }
}
