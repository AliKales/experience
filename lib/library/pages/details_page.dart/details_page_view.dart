import 'package:experiences/library/componets/icon_button_back.dart';
import 'package:experiences/library/componets/percent_indicator.dart';
import 'package:experiences/library/componets/widget_disable_scroll_glow.dart';
import 'package:experiences/library/funcs.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/models/model_price.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class DetailsPageView extends StatefulWidget {
  const DetailsPageView({Key? key, required this.item}) : super(key: key);

  final ModelItemExperience item;

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
                _bigText(context, widget.item.title ?? ""),
                _smallText(context, widget.item.description ?? ""),
                SimpleUIs().divider(context),
                _bigText(context, "Location"),
                _smallText(context, widget.item.country ?? ""),
                if (widget.item.locationURL != null)
                  ..._smallTextClickable(
                    context,
                    "Location",
                    () {
                      Funcs().launchLink("url", context, true);
                    },
                  ),
                SimpleUIs().divider(context),
                if (_checkAccommandationExisting)
                  _bigText(context, "Accommodation"),
                if (_checkAccommandationExisting)
                  _priceWidget(
                    context,
                    ModelPrice(
                      label: widget.item.accommandation?.type ?? "",
                      description: "One Night",
                      price: widget.item.accommandation?.price,
                    ),
                  ),
                if (_checkAccommandationExisting)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.item.accommandation?.details?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _smallText(context,
                          "-${widget.item.accommandation?.details?[index]}");
                    },
                  ),
                if (widget.item.accommandation?.instagram != null)
                  ..._smallTextClickable(context, "Instagram", () {}),
                if (widget.item.accommandation?.facebook != null)
                  ..._smallTextClickable(context, "Facebook", () {}),
                if (widget.item.accommandation?.website != null)
                  ..._smallTextClickable(context, "Website", () {}),
                if (widget.item.accommandation?.locationURL != null)
                  ..._smallTextClickable(context, "Location", () {}),
                if (_checkAccommandationExisting) SimpleUIs().divider(context),
                if (_checkPricesExisting)
                  Row(
                    children: [
                      Expanded(child: _bigText(context, "Prices")),
                      IconButton(
                        onPressed: () {
                          SimpleUIs.showInfoDialog(context: context);
                        },
                        icon: const Icon(Icons.info_outline_rounded),
                      ),
                    ],
                  ),
                if (_checkPricesExisting)
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.item.prices?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _priceWidget(context, widget.item.prices![index]);
                    },
                  ),
                if (_checkPricesExisting)
                  Align(
                      alignment: Alignment.centerRight,
                      child: _smallText(context, "= ${_calculatePrice()}")),
                if (_checkPricesExisting) SimpleUIs().divider(context),
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
                PercentIndicator(
                  reccomendation: widget.item.recommendation!,
                ),
                SizedBox(height: context.dynamicHeight(0.05)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _checkPricesExisting => widget.item.prices != null;

  bool get _checkAccommandationExisting => widget.item.accommandation != null;

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
          style: context.textTheme.headline5!
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

  String _calculatePrice() {
    double money = 0;
    for (var element in widget.item.prices ?? []) {
      if (element.price != null) {
        money += element.price!;
      }
    }
    return "= ${Funcs().formatMoney(money)}";
  }
}
