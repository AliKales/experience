import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../providers/bottom_navbar_provider.dart';
import '../values.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key? key,
    required this.selectedPage,
  }) : super(key: key);

  final int selectedPage;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        iconTheme: const IconThemeData(color: cIconColor, size: 30),
      ),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: cSecondryColor,
            ),
          ),
        ),
        width: double.maxFinite,
        height: kBottomNavigationBarHeight,
        child: Row(
          children: [
            _item(context, Icons.home_filled, 0, selectedPage),
            _item(context, Icons.search, 1, selectedPage),
            if (AuthFirebase().isSignedIn)
              _item(context, Icons.add_box_rounded, 2, selectedPage),
            _item(context, Icons.account_circle, 3, selectedPage),
          ],
        ),
      ),
    );
  }

  Widget _item(BuildContext context, IconData iconData, int itemNumber,
      int selectedPage) {
    return Expanded(
      child: InkWell(
        onTap: () => _changePage(context, itemNumber),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: context.dynamicHeight(0.01)),
            Icon(iconData),
            SizedBox(height: context.dynamicHeight(0.006)),
            if (itemNumber == selectedPage) _widgetUnderIcon(),
            SizedBox(height: context.dynamicHeight(0.01)),
          ],
        ),
      ),
    );
  }

  _changePage(BuildContext context, int itemNumber) =>
      Provider.of<BottomNavigationBarProvider>(context, listen: false)
          .changePage(itemNumber);

  Expanded _widgetUnderIcon() {
    return Expanded(
      child: Container(
        decoration:
            const BoxDecoration(color: cIconColor, shape: BoxShape.circle),
      ),
    );
  }
}
