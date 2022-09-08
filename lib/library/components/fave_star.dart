import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:flutter/material.dart';

import '../services/hive/hivedatabase.dart';

class FaveStar extends StatefulWidget {
  const FaveStar({
    Key? key,
    required this.itemId,
    required this.userId,
  }) : super(key: key);

  final String itemId;
  final String userId;

  @override
  State<FaveStar> createState() => _FaveStarState();
}

class _FaveStarState extends State<FaveStar> {
  bool isExist = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isExist = checkExisting;
  }

  @override
  Widget build(BuildContext context) {
    if (_check()) return SizedBox.shrink();
    return IconButton(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      onPressed: _handlePress,
      icon: Icon(
        isExist ? Icons.star : Icons.star_border,
        color: Colors.yellow,
        size: 32,
      ),
    );
  }

  bool _check() =>
      !AuthFirebase().isSignedIn || widget.userId == AuthFirebase().getUid;

  void _handlePress() {
    if (checkExisting) {
      HiveDatabase().removeFave(widget.itemId);
      SimpleUIs().showSnackBar(context, "Removed from favorites");
    } else {
      HiveDatabase().addFave(widget.itemId);
      SimpleUIs().showSnackBar(context, "Added to favorites");
    }

    setState(() {
      isExist = !isExist;
    });
  }

  bool get checkExisting => HiveDatabase().checkFave(widget.itemId);
}
