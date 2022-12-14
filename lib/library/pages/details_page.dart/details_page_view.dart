import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:experiences/library/components/custom_button.dart';
import 'package:experiences/library/components/percent_indicator.dart';
import 'package:experiences/library/components/widget_disable_scroll_glow.dart';
import 'package:experiences/library/funcs.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/models/model_price.dart';
import 'package:experiences/library/models/model_user.dart';
import 'package:experiences/library/pages/show_photos_page/show_photos_page_view.dart';
import 'package:experiences/library/pages/user_page/user_page_view.dart';
import 'package:experiences/library/services/firebase/firestore_firebase.dart';
import 'package:experiences/library/services/firebase/storage_firebase.dart';
import 'package:experiences/library/simple_uis.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../providers/user_page_provider.dart';

part 'mixin.dart';

class DetailsPageView extends StatefulWidget {
  const DetailsPageView(
      {Key? key,
      required this.item,
      this.photos,
      this.isNewExperience = false,
      this.letGoUserPage = true})
      : super(key: key);

  final ModelItemExperience item;
  final List<Uint8List>? photos;
  final bool? isNewExperience;
  final bool? letGoUserPage;

  @override
  State<DetailsPageView> createState() => _DetailsPageViewState();
}

class _DetailsPageViewState extends State<DetailsPageView>
    with SingleTickerProviderStateMixin, _Mixin {
  TabController? _tabController;

  final _bigTextLocation = "Location";
  final _smallTextClickLocation = "Location";
  final _bigTextAccomandation = "Accommodation";
  final _bigTextPrice = "Prices";
  final _bigTextPhotos = "Photos";
  final _bigTextReccomand = "Recommend";
  final _smallTextRecomandation =
      "How much does the user recommend this experience?";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.photos.isNotNullOrEmpty) init(widget.item);

    _handleTabControllers();
  }

  void _handleTabControllers() {
    if (widget.photos.isNotNullOrEmpty) {
      _tabController =
          TabController(length: widget.photos!.length, vsync: this);
    } else {
      _tabController =
          TabController(length: widget.item.photos!.length, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: context.paddingNormal,
        child: WidgetDisableScrollGlow(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _bigText(context, widget.item.title ?? ""),
                _smallText(context, widget.item.description ?? ""),
                SimpleUIs().divider(context),
                _bigText(context, _bigTextLocation),
                _smallText(context, widget.item.country ?? ""),
                if (widget.item.locationURL != null)
                  ..._smallTextClickable(
                    context,
                    _smallTextClickLocation,
                    () {
                      Funcs().launchLink(
                          widget.item.locationURL ?? "", context, true);
                    },
                  ),
                SimpleUIs().divider(context),
                if (_checkAccommandationExisting)
                  _bigText(context, _bigTextAccomandation),
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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.item.accommandation?.details?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _smallText(context,
                          "-${widget.item.accommandation?.details?[index].trim()}");
                    },
                  ),
                if (widget.item.accommandation?.instagram != null)
                  ..._smallTextClickable(
                      context,
                      "Instagram",
                      () => _handleTextClick(
                          context, widget.item.accommandation!.instagram!)),
                if (widget.item.accommandation?.facebook != null)
                  ..._smallTextClickable(
                      context,
                      "Facebook",
                      () => _handleTextClick(
                          context, widget.item.accommandation!.facebook!)),
                if (widget.item.accommandation?.website != null)
                  ..._smallTextClickable(
                      context,
                      "Website",
                      () => _handleTextClick(
                          context, widget.item.accommandation!.website!)),
                if (widget.item.accommandation?.locationURL != null)
                  ..._smallTextClickable(
                      context,
                      "Location",
                      () => _handleTextClick(
                          context, widget.item.accommandation!.locationURL!)),
                if (_checkAccommandationExisting) SimpleUIs().divider(context),
                if (_checkPricesExisting)
                  Row(
                    children: [
                      Expanded(child: _bigText(context, _bigTextPrice)),
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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.item.prices?.length ?? 0,
                    itemBuilder: (context, index) {
                      return _priceWidget(context, widget.item.prices![index]);
                    },
                  ),
                if (_checkPricesExisting)
                  Align(
                      alignment: Alignment.centerRight,
                      child: _smallText(context, _calculatePrice(widget.item))),
                if (_checkPricesExisting) SimpleUIs().divider(context),
                _bigText(context, _bigTextPhotos),
                if (_tabController != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TabPageSelector(
                      controller: _tabController,
                    ),
                  ),
                SizedBox(
                  height: context.dynamicHeight(0.01),
                ),
                if (_tabController != null)
                  InkWell(
                    onTap: () {
                      context.navigateToPage(
                        ShowPhotosPageView(
                          photosMemory: widget.photos,
                          photosUrl: widget.item.photos,
                        ),
                      );
                    },
                    child: SizedBox(
                      width: double.maxFinite,
                      height: context.dynamicHeight(0.3),
                      child: PageView.builder(
                        itemCount: _tabController!.length,
                        onPageChanged: (val) {
                          _tabController!.animateTo(val);
                        },
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: _image(index),
                        ),
                      ),
                    ),
                  ),
                SimpleUIs().divider(context),
                _bigText(context, _bigTextReccomand),
                _smallText(context, _smallTextRecomandation),
                SizedBox(height: context.dynamicHeight(0.02)),
                PercentIndicator(
                  reccomendation: widget.item.recommendation!,
                ),
                ...seeProfileOrShareWidget(),
                SizedBox(height: context.dynamicHeight(0.05)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _checkPricesExisting => widget.item.prices != null;

  //Here it cheks type because accommandation is never empty but type can be empty
  bool get _checkAccommandationExisting =>
      widget.item.accommandation?.type != null;

  List<Widget> seeProfileOrShareWidget() {
    if (widget.isNewExperience ?? false) {
      return [
        Align(
          alignment: Alignment.center,
          child: CustomButton(
            text: "Share",
            onTap: () {
              _handleShare(context, widget.photos!);
            },
          ),
        )
      ];
    }

    if (!widget.letGoUserPage!) return [const SizedBox.shrink()];
    return [
      SimpleUIs().divider(context),
      Align(
        alignment: Alignment.center,
        child: CustomButton.outlined(
          text: "User's Page",
          onTap: () {
            context.navigateToPage(UserPageView(
              userId: widget.item.userId,
            ));
          },
        ),
      ),
    ];
  }

  ClipRRect _image(int index) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(
        Radius.circular(cRadius),
      ),
      child: widget.photos == null
          ? CachedNetworkImage(
              imageUrl: widget.item.photos![index],
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: context.dynamicHeight(0.3),
            )
          : Image.memory(
              widget.photos![index],
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
      style:
          context.textTheme.headline6!.copyWith(fontWeight: FontWeight.normal),
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
