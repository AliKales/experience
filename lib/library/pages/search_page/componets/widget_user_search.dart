import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../models/model_user.dart';
import '../../../values.dart';

class WidgetUserSearch extends StatelessWidget {
  const WidgetUserSearch({
    Key? key,
    required this.user,
    this.onTap,
  }) : super(key: key);

  final ModelUser user;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const double padding = 10;
    const double marginVertical = 10;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(padding),
        margin: const EdgeInsets.symmetric(vertical: marginVertical),
        width: double.maxFinite,
        decoration: const BoxDecoration(
          color: cSecondryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(cRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.fullName ?? "",
                    style: context.textTheme.headline6!
                        .copyWith(fontWeight: FontWeight.bold)),
                Text("@${user.username}",
                    style: context.textTheme.subtitle1!
                        .copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
