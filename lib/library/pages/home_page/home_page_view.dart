import 'package:experiences/library/componets/custom_appbar.dart';
import 'package:experiences/library/componets/last_widget.dart';
import 'package:experiences/library/models/model_item_experience.dart';
import 'package:experiences/library/pages/details_page.dart/details_page_view.dart';
import 'package:experiences/library/values.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../componets/widget_disable_scroll_glow.dart';
import '../../componets/widget_item_experience.dart';
import '../../mixers/mixin_items.dart';
import '../../providers/item_experiences_provider.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView>
    with MixinItems, AutomaticKeepAliveClientMixin<HomePageView> {
  final _textNoItemsLoaded = "No Experience Yet";
  final _textAppBar = "Home";
  final _numberOfItemsFromDB = 10;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    List<ModelItemExperience> items =
        Provider.of<MotelItemExperienceProvider>(context).homePageItems;
    return Scaffold(
      appBar: CustomAppBar(text: _textAppBar, leadingIcon: Icons.home_filled),
      body: Padding(
        padding: cPagePadding,
        child:
            items.isNullOrEmpty ? _widgetNoExperiences() : _experiences(items),
      ),
    );
  }

  Widget _experiences(List<ModelItemExperience> items) {
    return WidgetDisableScrollGlow(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (index == items.length - 1 &&
              items.length > _numberOfItemsFromDB) {
            return LastWidget(
                onShown: () {
                  loadMore();
                },
                child: _widgetExperiences(items, index, context));
          }
          return _widgetExperiences(items, index, context);
        },
      ),
    );
  }

  WidgetItemExperience _widgetExperiences(
      List<ModelItemExperience> items, int index, BuildContext context) {
    return WidgetItemExperience(
      item: items[index],
      onTap: () async {
        await context.navigateToPage(
          DetailsPageView(item: items[index]),
        );
        //here we refresh in case of user adding it to favorites
        setState(() {});
      },
    );
  }

  Column _widgetNoExperiences() {
    return Column(
      children: [
        const Spacer(),
        Center(
          child: Text(
            _textNoItemsLoaded,
            style: context.textTheme.headline6!
                .copyWith(color: cSecondryColor, fontWeight: FontWeight.bold),
          ),
        ),
        const Spacer(),
      ],
    );
  }

  @override
  // TODO: implement isHome
  bool get isHome => true;

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
