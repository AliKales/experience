import 'package:experiences/library/components/custom_animated_text.dart';
import 'package:experiences/library/components/custom_button.dart';
import 'package:experiences/library/funcs.dart';
import 'package:experiences/library/pages/create_account_page/create_account_view.dart';
import 'package:experiences/library/pages/log_in_page/log_in_page_view.dart';
import 'package:experiences/library/pages/main_page/main_page_view.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class FirstPageView extends StatefulWidget {
  const FirstPageView({Key? key}) : super(key: key);

  @override
  State<FirstPageView> createState() => _FirstPageViewState();
}

class _FirstPageViewState extends State<FirstPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: context.paddingNormal,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomAnimatedKit(
                  values: ["WELCOME", "CREATE ACCOUNT", "LOG IN", "SKIP"],
                ),
                SizedBox(height: context.dynamicHeight(0.1)),

                //CustomButton (CREATE ACCOUNT)
                CustomButton(
                    text: "CREATE ACCOUNT",
                    onTap: () =>
                        context.navigateToPage(const CreateAccountView())),
                SizedBox(height: context.dynamicHeight(0.04)),

                //CustomButton (LOG IN)
                CustomButton.outlined(
                  text: "LOG IN",
                  onTap: () => context.navigateToPage(
                    const LogInPageView(),
                  ),
                ),
                SizedBox(height: context.dynamicHeight(0.04)),

                //CustomButton (SKIP) people who doesnt want to sign up or log in
                CustomButton.text(
                    text: "SKIP",
                    onTap: () => Funcs().navigatorPushReplacement(
                        context, const MainPageView())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
