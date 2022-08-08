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
  late List<TextEditingController> listTECs;

  final _createAccountButtonText = "Create Account";
  final _textFieldZero = "Full Name";
  final _textFieldsFirst = "Username";
  final _textFieldSecond = "Email";
  final _textFieldThird = "Password";
  final _textFieldFourth = "Confirm Password";
  final _textHead = "Register";
  final _textInformation = "Create your new account";

  @override
  void initState() {
    super.initState();
    listTECs = Funcs().createTECs(5);
  }

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
                  _textHead,
                  style: context.textTheme.headline4!.copyWith(
                    color: cTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.02),
                ),
                Text(
                  _textInformation,
                  style:
                      context.textTheme.headline6!.copyWith(color: cTextColor),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.05),
                ),
                CustomTextField(labelText: _textFieldZero, tEC: listTECs[0]),
                CustomTextField(labelText: _textFieldsFirst, tEC: listTECs[1]),
                CustomTextField(labelText: _textFieldSecond, tEC: listTECs[2]),
                CustomTextField(labelText: _textFieldThird, tEC: listTECs[3]),
                CustomTextField(labelText: _textFieldFourth, tEC: listTECs[4]),
                CustomButton(
                  text: _createAccountButtonText,
                  onTap: _handleCreateAccount,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleCreateAccount() {
    onButtonClick(listTECs);
  }

  AppBar _appBar() {
    return AppBar(
      leading: const IconButtonBack(),
    );
  }
}
