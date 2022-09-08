import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:experiences/library/components/custom_button.dart';
import 'package:experiences/library/components/custom_dropdown.dart';
import 'package:experiences/library/components/custom_radio.dart';
import 'package:experiences/library/components/custom_textfield.dart';
import 'package:experiences/library/components/no_exit_page.dart';
import 'package:experiences/library/models/model_accommandation.dart';
import 'package:experiences/library/models/model_country.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/pages/details_page.dart/details_page_view.dart';
import 'package:experiences/library/services/firebase/auth_firebase.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../components/custom_appbar.dart';
import '../../components/widget_disable_scroll_glow.dart';
import '../../funcs.dart';
import '../../models/model_price.dart';
import '../../simple_uis.dart';
import '../../values.dart';

part 'mixin.dart';
part 'photos_view.dart';
part 'prices_view.dart';

class NewPostPageView extends StatefulWidget {
  const NewPostPageView({Key? key}) : super(key: key);

  @override
  State<NewPostPageView> createState() => _NewPostPageViewState();
}

class _NewPostPageViewState extends State<NewPostPageView>
    with AutomaticKeepAliveClientMixin<NewPostPageView>, _Mixin {
  List<ModelCountry> countries = [];

  ModelItemExperience modelItemExperience = ModelItemExperience();

  ModelAccommandation modelAccommandation = ModelAccommandation();

  List<Uint8List> photos = [];

  final _textAppBar = "New Experience";
  final _textFiedTextTitle = "Title";
  final _textFiedTextDescription = "Description";
  final _bigTextLocation = "Location";
  final _dropDownCountry = "Country";
  final _textFieldSetLocation = "Set the location";
  final _buttonCheckLocation = "Check the location";
  final _bigTextAccomandation = "Accommodation (One Night)";
  final _dropDownAccomandation = "Type";
  final _textFieldDetailsAcco = "Details (Wifi,Breakfast...)";
  final _textFieldAccoPrice = "Price (\$13.40)";
  final _textFieldInsta = "Instagram Link";
  final _textFieldFacebook = "Facebook Link";
  final _textFieldWebsite = "Website Link";
  final _textFieldAccoLocation = "Location";
  final _bigTextPrices = "Prices";
  final _bigTextRecommend = "Recommend";
  final _smallTextRecommandation =
      "How much does the user recommend this experience?";
  final _buttonPreview = "Continue To Preview";

  @override
  void initState() {
    super.initState();

    _loadCountries();
  }

  void _loadCountries() {
    Funcs().getCountries().then((value) {
      countries = value;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NoExitPage(
      child: Scaffold(
        appBar: CustomAppBar(
          leadingIcon: Icons.add,
          text: _textAppBar,
        ),
        body: countries.isEmpty
            ? Center(
                child: SimpleUIs.progressIndicator(),
              )
            : body(),
      ),
    );
  }

  Padding body() {
    return Padding(
      padding: context.paddingNormal,
      child: WidgetDisableScrollGlow(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.dynamicHeight(0.02)),
              CustomTextField.outlined(
                labelText: _textFiedTextTitle,
                onChanged: (value) {
                  modelItemExperience.title = value;
                },
              ),
              CustomTextField.outlined(
                labelText: _textFiedTextDescription,
                onChanged: (value) {
                  modelItemExperience.description = value;
                },
              ),
              SimpleUIs().divider(context),
              bigText(context, _bigTextLocation),
              CustomDropDown(
                hintText: _dropDownCountry,
                items: _getCountriesJustNames(),
                onChanged: (value) {
                  modelItemExperience.country = value;
                  modelItemExperience.countryCode = countries
                      .firstWhereOrNull((element) => element.name == value)
                      ?.code;
                },
              ),
              CustomTextField.outlined(
                labelText: _textFieldSetLocation,
                onChanged: (String value) {
                  modelItemExperience.locationURL = value.trim();
                },
              ),
              CustomButton.text(
                text: _buttonCheckLocation,
                color: Colors.blue,
                onTap: () {
                  String? url = modelItemExperience.locationURL;
                  if (url.isNotNullOrNoEmpty) Funcs().launchLink(url!);
                },
              ),
              SimpleUIs().divider(context),
              bigText(context, _bigTextAccomandation),
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
                hintText: _dropDownAccomandation,
                items: Accommodation.getAsList(),
                onChanged: (value) {
                  modelAccommandation.type = value;
                },
              ),
              CustomTextField.outlined(
                labelText: _textFieldDetailsAcco,
                onChanged: (String value) {
                  modelAccommandation.details = value.split(",");
                },
              ),
              CustomTextField.outlined(
                labelText: _textFieldAccoPrice,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (String value) {
                  modelAccommandation.price = double.tryParse(value);
                },
              ),
              CustomTextField.outlined(
                labelText: _textFieldInsta,
                onChanged: (String value) {
                  modelAccommandation.instagram = value;
                },
              ),
              CustomTextField.outlined(
                labelText: _textFieldFacebook,
                onChanged: (String value) {
                  modelAccommandation.facebook = value;
                },
              ),
              CustomTextField.outlined(
                labelText: _textFieldWebsite,
                onChanged: (String value) {
                  modelAccommandation.website = value;
                },
              ),
              CustomTextField.outlined(
                labelText: _textFieldAccoLocation,
                onChanged: (String value) {
                  modelAccommandation.locationURL = value;
                },
              ),
              SimpleUIs().divider(context),
              Row(
                children: [
                  Expanded(child: bigText(context, _bigTextPrices)),
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
              _PhotosView(
                onPhotoAdd: (photo) {
                  photos.add(photo);
                },
                onPhotoDelete: (index) {
                  photos.removeAt(index);
                },
              ),
              SimpleUIs().divider(context),
              bigText(context, _bigTextRecommend),
              smallText(context, _smallTextRecommandation),
              SizedBox(height: context.dynamicHeight(0.02)),
              CustomRadio(
                onChanged: (value) {
                  modelItemExperience.recommendation = value;
                },
              ),
              SizedBox(height: context.dynamicHeight(0.05)),
              CustomButton(
                text: _buttonPreview,
                onTap: _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<String> _getCountriesJustNames() =>
      countries.map((e) => e.name ?? "").toList();

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

  void _handleContinue() async {
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
    if (photos.isNullOrEmpty) {
      SimpleUIs().showSnackBar(context, "Photos can not be empty!");
      return;
    }

    modelItemExperience.accommandation = modelAccommandation;

    modelItemExperience.userId = AuthFirebase().getUid;

    bool? result = await context.navigateToPage(
      DetailsPageView(
        item: modelItemExperience,
        photos: photos,
        isNewExperience: true,
      ),
    );

    if (result == null || !result) return;

    modelItemExperience = ModelItemExperience();
    photos.clear();
    modelAccommandation = ModelAccommandation();
    setState(() {});
  }

  bool _isStringEmpty(String? text) {
    return text == null || text.trim() == "";
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
