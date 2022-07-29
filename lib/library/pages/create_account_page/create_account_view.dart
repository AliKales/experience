import 'package:experiences/library/componets/custom_button.dart';
import 'package:experiences/library/componets/custom_textfield.dart';
import 'package:experiences/library/componets/widget_disable_scroll_glow.dart';
import 'package:experiences/library/models/model_user.dart';
import 'package:experiences/library/pages/main_page/main_page_view.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/services/firebase/firestore_firebase.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../componets/icon_button_back.dart';
import '../../funcs.dart';

part 'mixin.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({Key? key}) : super(key: key);

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> with _Mixin {
  List<TextEditingController> listTECs = List.generate(
    5,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: cPagePadding,
        child: WidgetDisableScrollGlow(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Register",
                  style: context.textTheme.headline4!.copyWith(
                    color: cTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.02),
                ),
                Text(
                  "Create your new account",
                  style:
                      context.textTheme.headline6!.copyWith(color: cTextColor),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.05),
                ),
                CustomTextField(labelText: "Full Name", tEC: listTECs[0]),
                CustomTextField(labelText: "Username", tEC: listTECs[1]),
                CustomTextField(labelText: "Email", tEC: listTECs[2]),
                CustomTextField(labelText: "Password", tEC: listTECs[3]),
                CustomTextField(
                    labelText: "Confirm Password", tEC: listTECs[4]),
                CustomButton(
                  text: "Create Account",
                  onTap: () {
                    onButtonClick(listTECs);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: const IconButtonBack(),
    );
  }
}
