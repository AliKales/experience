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
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _image(context),
            Padding(
              padding: context.paddingNormal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleNStar(context),
                  if (item.username != null) _userName(context),
                  _countryNIcon(context),
                  _time(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding _time(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          Funcs().getTimeWhenShared(DateTime.parse(item.createdDate!)),
          style: context.textTheme.subtitle1!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Row _countryNIcon(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        const Icon(Icons.location_on),
        Text(
          item.country ?? "",
          style: context.textTheme.headline6!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Text _userName(BuildContext context) {
    return Text(
      "@${item.username}",
      style: context.textTheme.headline6!.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Row _titleNStar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            item.title ?? "",
            style: context.textTheme.headline5!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (isStarShown!) FaveStar(itemId: item.id!, userId: item.userId!),
      ],
    );
  }

  ClipRRect _image(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(cRadius),
      ),
      child: CachedNetworkImage(
        imageUrl: item.photos!.first,
        fit: BoxFit.cover,
        width: double.maxFinite,
        height: context.dynamicHeight(0.3),
      ),
    );
  }
}
