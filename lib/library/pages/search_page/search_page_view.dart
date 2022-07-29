import 'package:experiences/library/componets/custom_textfield.dart';
import 'package:experiences/library/componets/widget_disable_scroll_glow.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../componets/custom_appbar.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({Key? key}) : super(key: key);

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  final double padding = 10;
  final double marginVertical = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(text: "Search", leadingIcon: Icons.search),
      body: Padding(
        padding: cPagePadding,
        child: Column(
          children: [
            const CustomTextField(
              labelText: "Search",
            ),
            Expanded(
              child: WidgetDisableScrollGlow(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(padding),
                      margin: EdgeInsets.symmetric(vertical: marginVertical),
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
                              Text("Ali Kaleş",
                                  style: context.textTheme.headline6!
                                      .copyWith(fontWeight: FontWeight.bold)),
                              Text("@ali.kales",
                                  style: context.textTheme.subtitle1!
                                      .copyWith(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const Icon(Icons.arrow_forward_ios),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
