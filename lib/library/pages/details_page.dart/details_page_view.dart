import 'package:experiences/library/componets/icon_button_back.dart';
import 'package:experiences/library/componets/percent_indicator.dart';
import 'package:experiences/library/componets/widget_disable_scroll_glow.dart';
import 'package:experiences/library/funcs.dart';
import 'package:experiences/library/models/model_price.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class DetailsPageView extends StatefulWidget {
  const DetailsPageView({Key? key}) : super(key: key);

  @override
  State<DetailsPageView> createState() => _DetailsPageViewState();
}

class _DetailsPageViewState extends State<DetailsPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonBack(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: cPagePadding,
        child: WidgetDisableScrollGlow(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bigText(context, "Title"),
                _smallText(context, "Description will be shown here"),
                SimpleUIs().divider(context),
                _bigText(context, "Location"),
                _smallText(context, "Bern\nSwitzerland"),
                ..._smallTextClickable(context, "Location", () {}),
                SimpleUIs().divider(context),
                _bigText(context, "Stay"),
                _priceWidget(
                    context,
                    ModelPrice(
                        label: "Hotel", description: "One Night", price: 20.0)),
                _smallText(context, "-Wifi"),
                ..._smallTextClickable(context, "Instagram", () {}),
                ..._smallTextClickable(context, "Facebook", () {}),
                ..._smallTextClickable(context, "Website", () {}),
                ..._smallTextClickable(context, "Location", () {}),
                SimpleUIs().divider(context),
                Row(
                  children: [
                    Expanded(child: _bigText(context, "Prices")),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.info_outline_rounded),
                    ),
                  ],
                ),
                _priceWidget(
                    context,
                    ModelPrice(
                        label: "Food&Drink",
                        description: "Daily",
                        price: 12.3)),
                _priceWidget(
                    context,
                    ModelPrice(
                        label: "Transport", description: "Daily", price: 12.3)),
                Align(
                    alignment: Alignment.centerRight,
                    child:
                        _smallText(context, "= ${Funcs().formatMoney(24.6)}")),
                SimpleUIs().divider(context),
                _bigText(context, "Photos"),
                Align(
                  alignment: Alignment.centerRight,
                  child: TabPageSelector(
                    selectedColor: cTextColor,
                    controller: _tabController,
                  ),
                ),
                SizedBox(
                  height: context.dynamicHeight(0.01),
                ),
                SizedBox(
                  width: double.maxFinite,
                  height: context.dynamicHeight(0.3),
                  child: PageView.builder(
                    itemCount: 3,
                    onPageChanged: (val) {
                      _tabController.animateTo(val);
                    },
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: _image(context),
                    ),
                  ),
                ),
                SimpleUIs().divider(context),
                _bigText(context, "Recommend"),
                _smallText(context,
                    "How much does the user recommend this experience?"),
                SizedBox(height: context.dynamicHeight(0.02)),
                const PercentIndicator(),
                SizedBox(height: context.dynamicHeight(0.05)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ClipRRect _image(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(cRadius),
      ),
      child: Image.asset(
        "assets/images/walk.jpg",
        fit: BoxFit.cover,
        width: double.maxFinite,
        height: context.dynamicHeight(0.3),
      ),
    );
  }

  Widget _bigText(BuildContext context, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: context.textTheme.headline4!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: context.dynamicHeight(0.01)),
      ],
    );
  }

  Widget _priceWidget(BuildContext context, ModelPrice modelPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _smallText(context, modelPrice.label ?? "")),
            _smallText(context, Funcs().formatMoney(modelPrice.price ?? 0)),
          ],
        ),
        _smallerText(context, "(${modelPrice.description})"),
      ],
    );
  }

  Text _smallText(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Text _smallerText(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.subtitle1!.copyWith(),
    );
  }

  List _smallTextClickable(
      BuildContext context, String text, VoidCallback onClick) {
    return [
      SizedBox(height: context.dynamicHeight(0.02)),
      InkWell(
        onTap: onClick,
        child: Text(
          text,
          style: context.textTheme.headline6!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
      ),
      SizedBox(height: context.dynamicHeight(0.02)),
    ];
  }
}
