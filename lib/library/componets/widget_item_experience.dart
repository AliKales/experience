import 'package:cached_network_image/cached_network_image.dart';
import 'package:experiences/library/funcs.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../values.dart';
import 'fave_star.dart';

class WidgetItemExperience extends StatelessWidget {
  const WidgetItemExperience({
    Key? key,
    this.onTap,
    required this.item,
    this.isStarShown = true,
  }) : super(key: key);

  final VoidCallback? onTap;
  final ModelItemExperience item;
  final bool? isStarShown;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(cRadius),
            ),
            child: CachedNetworkImage(
              imageUrl: item.photos!.first,
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: context.dynamicHeight(0.3),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item.title ?? "",
                    style: context.textTheme.headline5!.copyWith(
                      color: cTextColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isStarShown!)
                  FaveStar(itemId: item.id!, userId: item.userId!),
              ],
            ),
          ),
          if (item.username != null)
            Text(
              "@${item.username}",
              style: context.textTheme.headline6!.copyWith(
                color: cTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          Row(
            children: [
              const Spacer(),
              const Icon(Icons.location_on),
              Text(
                item.country ?? "",
                style: context.textTheme.headline6!.copyWith(
                  color: cTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                Funcs().getTimeWhenShared(DateTime.parse(item.createdDate!)),
                style: context.textTheme.subtitle1!.copyWith(
                  color: cTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          SizedBox(height: context.dynamicHeight(0.03)),
          const Divider(),
          SizedBox(height: context.dynamicHeight(0.03)),
        ],
      ),
    );
  }
}
