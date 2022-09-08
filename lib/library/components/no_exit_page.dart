import 'package:experiences/library/providers/bottom_navbar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NoExitPage extends StatelessWidget {
  const NoExitPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async {
        Provider.of<BottomNavigationBarProvider>(context, listen: false)
            .changePage(0);
        return false;
      },
    );
  }
}
