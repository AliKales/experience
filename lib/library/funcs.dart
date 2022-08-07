import 'dart:convert';
import 'dart:typed_data';

import 'package:experiences/library/componets/custom_button.dart';
import 'package:experiences/library/models/model_country.dart';
import 'package:experiences/library/pages/crop_page/crop_page_view.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:money_formatter/money_formatter.dart';
import 'package:url_launcher/url_launcher.dart';

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

  Future<Uint8List?> getImage(BuildContext context,
      [bool? isProfilePic, double? mH, double? mW]) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(
        source: ImageSource.gallery, maxHeight: mH, maxWidth: mW);

    if (image == null) return null;

    var bytes = await image.readAsBytes();

    Uint8List? bytesCroped = await context.navigateToPage(
      CropPageView(
        bytes: bytes,
        isProfilePic: isProfilePic,
      ),
    );

    if (bytesCroped == null) return null;

    return bytesCroped;
  }

  Future<List<ModelCountry>> getCountries() async {
    final String response =
        await rootBundle.loadString('assets/jsons/countries.json');
    final data = await json.decode(response);

    List<ModelCountry> list = data['countries']
        .map((e) => ModelCountry.fromJson(e))
        .toList()
        .cast<ModelCountry>();

    return list;
  }

  Future<void> launchLink(String url,
      [BuildContext? context, bool showAlert = false]) async {
    if (!url.contains("https://") && !url.contains("http://")) {
      url.replaceAll("https://", "");
      url.replaceAll("http://", "");
      url = "https://$url";
    }
    if (showAlert && context != null) {
      bool result = false;

      await SimpleUIs.dialogCustom(
        context: context,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                "WARNING!",
                style: context.textTheme.headline6!
                    .copyWith(color: cTextColor, fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              "You want to open a link which is provided by user so we do NOT know if the link is safe. Please check the link before you click\n\n$url",
              style: context.textTheme.subtitle1!
                  .copyWith(color: cTextColor, fontWeight: FontWeight.bold),
            ),
            CustomButton(
              text: "Open The Link",
              onTap: () {
                result = true;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );

      if (!result) return;
    }

    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      if (context != null) SimpleUIs().showSnackBar(context, "ERROR!");
    }
  }

  String getTimeWhenShared(DateTime itemDateTime) {
    DateTime currentDateTime = getGMTDateTimeNow();

    Duration diffrence = currentDateTime.difference(itemDateTime);

    String valToREturn = "";

    if (diffrence.inDays != 0) {
      if (diffrence.inDays >= 365) {
        valToREturn = "${diffrence.inDays / 365} years ago";
      } else if (diffrence.inDays >= 30) {
        valToREturn = "${diffrence.inDays / 30} months ago";
      } else {
        valToREturn = "${diffrence.inDays} days ago";
      }
    } else if (diffrence.inHours != 0) {
      valToREturn = "${diffrence.inHours} hours ago";
    } else if (diffrence.inMinutes >= 0) {
      valToREturn = "${diffrence.inMinutes} minutes ago";
    } else if (diffrence.inSeconds <= 0) {
      valToREturn = "1 second ago";
    } else {
      valToREturn = "${diffrence.inSeconds} seconds ago";
    }

    return valToREturn;
  }
}
