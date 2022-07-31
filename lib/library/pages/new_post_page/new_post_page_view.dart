import 'package:experiences/library/componets/custom_button.dart';
import 'package:experiences/library/componets/custom_dropdown.dart';
import 'package:experiences/library/componets/custom_radio.dart';
import 'package:experiences/library/componets/custom_textfield.dart';
import 'package:experiences/library/models/model_accommandation.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/pages/details_page.dart/details_page_view.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../componets/icon_button_back.dart';
import '../../componets/widget_disable_scroll_glow.dart';
import '../../funcs.dart';
import '../../models/model_price.dart';
import '../../simple_uis.dart';
import '../../values.dart';

part 'mixin.dart';
part 'prices_view.dart';
part 'photos_view.dart';

class NewPostPageView extends StatefulWidget {
  const NewPostPageView({Key? key}) : super(key: key);

  @override
  State<NewPostPageView> createState() => _NewPostPageViewState();
}

class _NewPostPageViewState extends State<NewPostPageView>
    with
        
        AutomaticKeepAliveClientMixin<NewPostPageView>,
        _Mixin {
  List<String> countries = [];

  ModelItemExperience modelItemExperience = ModelItemExperience();

  ModelAccommandation modelAccommandation = ModelAccommandation();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Funcs().getCountries().then((value) {
      countries = value.map((e) => e.name ?? "").toList();
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        leading: const IconButtonBack(),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: countries.isEmpty
          ? Center(
              child: SimpleUIs.progressIndicator(),
            )
          : body(),
    );
  }

  Padding body() {
    return Padding(
      padding: cPagePadding,
      child: WidgetDisableScrollGlow(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField.outlined(
                labelText: "Title",
                onChanged: (value) {
                  modelItemExperience.title = value;
                },
              ),
              CustomTextField.outlined(
                labelText: "Description",
                onChanged: (value) {
                  modelItemExperience.description = value;
                },
              ),
              SimpleUIs().divider(context),
              bigText(context, "Location"),
              CustomDropDown(
                hintText: "Country",
                items: countries,
                onChanged: (value) {
                  modelItemExperience.country = value;
                },
              ),
              CustomTextField.outlined(
                labelText: "Set the location",
                onChanged: (String value) {
                  modelItemExperience.locationURL = value.trim();
                },
              ),
              CustomButton.text(
                text: "Check the location",
                color: Colors.blue,
                onTap: () {
                  String? url = modelItemExperience.locationURL;
                  if (url != null && url.isNotEmpty) Funcs().launchLink(url);
                },
              ),
              SimpleUIs().divider(context),
              bigText(context, "Accommodation (One Night)"),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    SimpleUIs.showInfoDialog(context: context);
                  },
                  icon: const Icon(Icons.info_outline_rounded),
                ),
              ),
              CustomDropDown(
                hintText: "Type",
                items: Accommodation.values.map((e) => e.name).toList(),
                onChanged: (value) {
                  modelAccommandation.type = value;
                },
              ),
              CustomTextField.outlined(
                labelText: "Details (Wifi,Breakfast...)",
                onChanged: (String value) {
                  modelAccommandation.details = value.split(",");
                },
              ),
              CustomTextField.outlined(
                labelText: "Price (\$13.40)",
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (String value) {
                  modelAccommandation.price = double.tryParse(value);
                },
              ),
              CustomTextField.outlined(
                labelText: "Instagram Link",
                onChanged: (String value) {
                  modelAccommandation.instagram = value;
                },
              ),
              CustomTextField.outlined(
                labelText: "Facebook Link",
                onChanged: (String value) {
                  modelAccommandation.facebook = value;
                },
              ),
              CustomTextField.outlined(
                labelText: "Website Link",
                onChanged: (String value) {
                  modelAccommandation.website = value;
                },
              ),
              CustomTextField.outlined(
                labelText: "Location",
                onChanged: (String value) {
                  modelAccommandation.locationURL = value;
                },
              ),
              SimpleUIs().divider(context),
              Row(
                children: [
                  Expanded(child: bigText(context, "Prices")),
                  IconButton(
                    onPressed: () {
                      SimpleUIs.showInfoDialog(context: context);
                    },
                    icon: const Icon(Icons.info_outline_rounded),
                  ),
                ],
              ),
              _PricesView(
                onChanged: (value) {
                  modelItemExperience.prices = value;
                },
              ),
              SimpleUIs().divider(context),
              _PhotosView(),
              SimpleUIs().divider(context),
              bigText(context, "Recommend"),
              smallText(
                  context, "How much does the user recommend this experience?"),
              SizedBox(height: context.dynamicHeight(0.02)),
              CustomRadio(
                onChanged: (value) {
                  modelItemExperience.recommendation = value;
                },
              ),
              SizedBox(height: context.dynamicHeight(0.05)),
              CustomButton(
                text: "Continue To Preview",
                onTap: _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bigText(BuildContext context, String text) {
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

  Text smallText(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.headline6!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Text smallerText(BuildContext context, String text) {
    return Text(
      text,
      style: context.textTheme.subtitle1!.copyWith(),
    );
  }

  List smallTextClickable(
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

  void _handleContinue() {
    if (_isStringEmpty(modelItemExperience.title)) {
      SimpleUIs().showSnackBar(context, "Title can not be empty!");
      return;
    }
    if (_isStringEmpty(modelItemExperience.description)) {
      SimpleUIs().showSnackBar(context, "Description can not be empty!");
      return;
    }
    if (_isStringEmpty(modelItemExperience.country)) {
      SimpleUIs().showSnackBar(context, "Country can not be empty!");
      return;
    }
    if (modelItemExperience.recommendation == null) {
      SimpleUIs().showSnackBar(context, "Recommendation can not be empty!");
      return;
    }

    modelItemExperience.accommandation = modelAccommandation;

    context.navigateToPage(
      DetailsPageView(
        item: modelItemExperience,
      ),
    );
  }

  bool _isStringEmpty(String? text) {
    return text == null || text.trim() == "";
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
