import 'package:experiences/library/componets/icon_button_back.dart';
import 'package:experiences/library/componets/widget_image.dart';
import 'package:experiences/library/funcs.dart';
import 'package:experiences/library/pages/main_page/main_page_view.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../componets/custom_button.dart';
import '../../componets/custom_textfield.dart';
import '../../simple_uis.dart';
import '../../values.dart';

part 'mixin.dart';

class LogInPageView extends StatefulWidget {
  const LogInPageView({Key? key}) : super(key: key);

  @override
  State<LogInPageView> createState() => _LogInPageViewState();
}

class _LogInPageViewState extends State<LogInPageView> with _Mixin {
  List<TextEditingController> listTECs = List.generate(
    2,
    (index) => TextEditingController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: Padding(
        padding: cPagePadding,
        child: Column(
          children: [
            Text(
              "Welcome",
              style: context.textTheme.headline4!.copyWith(
                color: cTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: context.dynamicHeight(0.02),
            ),
            Text(
              "Log into your account",
              style: context.textTheme.headline6!.copyWith(color: cTextColor),
            ),
            SizedBox(
              height: context.dynamicHeight(0.05),
            ),
            CustomTextField(labelText: "Email", tEC: listTECs.first),
            CustomTextField(labelText: "Password", tEC: listTECs[1]),
            SizedBox(height: context.dynamicHeight(0.02)),
            const WidgetImage(boxFit: BoxFit.cover),
            SizedBox(height: context.dynamicHeight(0.02)),
            CustomButton(
              text: "Log IN",
              onTap: () => _onButtonTap(listTECs),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _appBar() => AppBar(
        leading: const IconButtonBack(),
      );
}
