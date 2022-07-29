part of 'create_account_view.dart';

mixin _Mixin<T extends StatefulWidget> on State<T> {
  String lastUsername = "";

  void onButtonClick(List<TextEditingController> listTECs) async {
    if (!Funcs().checkIfTECsEmpty(listTECs)) {
      SimpleUIs().showSnackBar(context, "Please fill every blank!");
      return;
    }

    if (listTECs[4].text.trim() != listTECs[3].text.trim()) {
      SimpleUIs().showSnackBar(context, "Passwords dont match");
      return;
    }
    SimpleUIs().showProgressIndicator(context);

    if (lastUsername == _getUsername(listTECs) ||
        await _checkUser(context, listTECs)) {
      Navigator.pop(context);
      SimpleUIs().showSnackBar(context, "This username is already taken");
      lastUsername = _getUsername(listTECs);
      return;
    }

    bool result = await AuthFirebase()
        .signUp(context, listTECs[2].text.trim(), listTECs[3].text.trim());

    if (!result) {
      Navigator.pop(context);
      return;
    }

    ModelUser modelUser = ModelUser(
      fullName: listTECs.first.text.trim(),
      username: _getUsername(listTECs),
      id: AuthFirebase().getUid,
      createdDate: Funcs().getGMTDateTimeNow().toIso8601String(),
    );

    bool result2 =
        await FirestoreFirebase.setUser(context: context, modelUser: modelUser);

    Navigator.pop(context);
    if (result2) {
      Funcs().navigatorPushReplacement(context, const MainPageView());
    }
  }
}

String _getUsername(List<TextEditingController> listTECs) =>
    listTECs[1].text.trim().toLowerCase();

Future<bool> _checkUser(context, List<TextEditingController> listTECs) async {
  return await FirestoreFirebase.getUser(
          context: context, username: _getUsername(listTECs)) !=
      null;
}
