part of 'log_in_page_view.dart';

mixin _Mixin<T extends StatefulWidget> on State<LogInPageView> {
  void _onButtonTap(List<TextEditingController> listTECs) async {
    if (!Funcs().checkIfTECsEmpty(listTECs)) {
      SimpleUIs().showSnackBar(context, "Please fill every blank!");
      return;
    }
    bool result = await AuthFirebase()
        .logIn(context, listTECs.first.text.trim(), listTECs[1].text.trim());

    if (!result) return;

    Funcs().navigatorPushReplacement(context, const MainPageView());
  }
}
