import 'package:experiences/library/components/icon_button_back.dart';
import 'package:experiences/library/funcs.dart';
import 'package:experiences/library/pages/main_page/main_page_view.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../components/custom_button.dart';
import '../../components/custom_textfield.dart';
import '../../simple_uis.dart';

part 'mixin.dart';

class LogInPageView extends StatefulWidget {
  const LogInPageView({Key? key}) : super(key: key);

  @override
  State<LogInPageView> createState() => _LogInPageViewState();
}

class _LogInPageViewState extends State<LogInPageView> with _Mixin {
  late List<TextEditingController> listTECs;

  final _textFieldZero = "Email";
  final _textFieldFirst = "Password";
  final _buttonText = "Log In";
  final _textHead = "Welcome";
  final _textInformation = "Log into your account";

  @override
  void initState() {
    super.initState();

    listTECs = Funcs().createTECs(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: context.paddingNormal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                _textHead,
                style: context.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: context.dynamicHeight(0.02),
              ),
              Text(
                _textInformation,
                style: context.textTheme.headline6!,
              ),
              SizedBox(
                height: context.dynamicHeight(0.05),
              ),
              CustomTextField(labelText: _textFieldZero, tEC: listTECs.first),
              CustomTextField(labelText: _textFieldFirst, tEC: listTECs[1]),
              SizedBox(height: context.dynamicHeight(0.05)),
              CustomButton(
                text: _buttonText,
                onTap: () => _onButtonTap(listTECs),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        leading: const IconButtonBack(),
      );
}
