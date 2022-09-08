import 'package:experiences/library/components/custom_animated_text.dart';
import 'package:experiences/library/funcs.dart';
import 'package:experiences/library/pages/first_page/first_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/bottom_navbar_provider.dart';

class LoadingPageView extends StatelessWidget {
  const LoadingPageView({Key? key}) : super(key: key);

  _afterBuild(context) async {
    await Future.delayed(const Duration(seconds: 2));
    Provider.of<BottomNavigationBarProvider>(context, listen: false)
        .changePage(0);
    Funcs().navigatorPushReplacement(context, const FirstPageView());
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _afterBuild(context));

    return Scaffold(
      body: Center(
        child: Theme(
          data: ThemeData(
            textTheme: const TextTheme(
              headline5: TextStyle(fontFamily: "Taviraj"),
            ),
          ),
          child: const CustomAnimatedKit(
            values: ["WELCOME", "EXPERIENCES"],
          ),
        ),
      ),
    );
  }
}
