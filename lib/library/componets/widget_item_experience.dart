import 'package:experiences/library/models/model_item_experience.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import '../values.dart';

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
            child: Image.asset(
              "assets/images/walk.jpg",
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: context.dynamicHeight(0.3),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Title will be shown here",
                  style: context.textTheme.headline5!.copyWith(
                    color: cTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (isStarShown!)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.star_border,
                    color: Colors.yellow,
                  ),
                ),
            ],
          ),
          Text(
            "@ali.kales",
            style: context.textTheme.headline6!.copyWith(
              color: cTextColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          Row(
            children: [
              const Spacer(),
              const Icon(Icons.location_on),
              Text(
                "Zuric/CH",
                style: context.textTheme.headline6!.copyWith(
                  color: cTextColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          SizedBox(height: context.dynamicHeight(0.03)),
          const Divider(),
          SizedBox(height: context.dynamicHeight(0.03)),
        ],
      ),
    );
  }
}
