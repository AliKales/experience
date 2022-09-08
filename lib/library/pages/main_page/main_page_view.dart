import 'package:experiences/library/components/c_navigation_bar.dart';
import 'package:experiences/library/pages/main_page/main_page_page_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_bottom_bar.dart';
import '../../providers/bottom_navbar_provider.dart';

class MainPageView extends StatelessWidget {
  const MainPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedPage =
        Provider.of<BottomNavigationBarProvider>(context).selectedPage;
    return Scaffold(
      bottomNavigationBar: CNavigationBar(selectedPage: selectedPage),
      body: MainPagePageView(selectedPage: selectedPage),
    );
  }
}
