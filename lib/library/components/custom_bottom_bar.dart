import 'package:experiences/library/providers/bottom_navbar_provider.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomButtonBar extends StatelessWidget {
  const CustomButtonBar(this.isElevated, this.isVisible);

  final bool isElevated;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: cPrimaryColor,
      duration: const Duration(milliseconds: 200),
      child: BottomAppBar(
        color: cPrimaryColor,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 13),
          child: Row(
            children: <Widget>[
              ...List.generate(
                3,
                (index) => _item(index, context),
              ),
              const Spacer(),
              FloatingActionButton(
                onPressed: () {
                  if (!AuthFirebase().isSignedIn) {
                    SimpleUIs().showSnackBar(
                        context, "You need an account to share an experience!");
                    return;
                  }

                  _onTap(3, context);
                },
                elevation: 0,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _item(int index, context) {
    return IconButton(
      onPressed: () => _onTap(index, context),
      iconSize: 30,
      icon: Icon(
        _getIcon(index),
      ),
    );
  }

  IconData? _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_filled;
      case 1:
        return Icons.search;
      case 2:
        return Icons.account_circle;
      default:
        Icons.home_filled;
    }
    return null;
  }

  void _onTap(int index, context) {
    Provider.of<BottomNavigationBarProvider>(context, listen: false)
        .changePage(index);
  }
}
